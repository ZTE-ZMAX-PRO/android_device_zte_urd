/*
 * Copyright (C) 2016 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "light"

#include "Light.h"

#include <log/log.h>

namespace {
using android::hardware::light::V2_0::LightState;

static const char* const LED_BLINK_TIME_FMT = "/sys/class/leds/%s/led_time";
static const char* const LED_BLINK_FMT = "/sys/class/leds/%s/blink";
static const char* const LED_BRIGHTNESS_FMT = "/sys/class/leds/%s/brightness";

static const char* const COLOR_STR[] = {
    "red", "green", "blue"
};

static const char* const lcd_backlight_filename =
    "/sys/class/leds/lcd-backlight/brightness";

static void
write_file(const char *path, const char *str)
{
    int fd;
    ssize_t written = -1;

    ALOGI("%s: path=%s str=%s\n", __func__, path, str);
    fd = open(path, O_RDWR);
    if (fd < 0) {
        ALOGE("%s: Failed to open %s: %s\n",
                __func__, path, strerror(errno));
        return;
    }
    written = write(fd, str, strlen(str));
    if (written < 0) {
        ALOGE("%s: Failed to write to %s: %s\n",
                __func__, path, strerror(errno));
    }
    close(fd);
}

static uint32_t rgbToBrightness(const LightState& state) {
    uint32_t color = state.color & 0x00ffffff;
    return ((77 * ((color >> 16) & 0xff)) + (150 * ((color >> 8) & 0xff)) +
            (29 * (color & 0xff))) >> 8;
}

static bool isLit(const LightState& state) {
    return (state.color & 0x00ffffff);
}
} // anonymous namespace

namespace android {
namespace hardware {
namespace light {
namespace V2_0 {
namespace implementation {

static constexpr uint32_t MODE_ON = 0x1;
static constexpr uint32_t MODE_BLINK = 0x2;

static constexpr uint32_t MODE_SHIFT = 24;
static constexpr uint32_t MODE_MASK = 0x0f000000;

Light::Light()
{
    auto attnFn(std::bind(&Light::setAttentionLight, this, std::placeholders::_1));
    auto backlightFn(std::bind(&Light::setBacklight, this, std::placeholders::_1));
    auto batteryFn(std::bind(&Light::setBatteryLight, this, std::placeholders::_1));
    auto notifFn(std::bind(&Light::setNotificationLight, this, std::placeholders::_1));
    mLights.emplace(std::make_pair(Type::ATTENTION, attnFn));
    mLights.emplace(std::make_pair(Type::BACKLIGHT, backlightFn));
    mLights.emplace(std::make_pair(Type::BATTERY, batteryFn));
    mLights.emplace(std::make_pair(Type::NOTIFICATIONS, notifFn));
}

// Methods from ::android::hardware::light::V2_0::ILight follow.
Return<Status> Light::setLight(Type type, const LightState& state) {
    auto it = mLights.find(type);

    if (it == mLights.end()) {
        return Status::LIGHT_NOT_SUPPORTED;
    }

    it->second(state);

    return Status::SUCCESS;
}

Return<void> Light::getSupportedTypes(getSupportedTypes_cb _hidl_cb) {
    std::vector<Type> types;

    for (auto const& light : mLights) {
        types.push_back(light.first);
    }

    _hidl_cb(types);

    return Void();
}

void Light::setAttentionLight(const LightState& state) {
    std::lock_guard<std::mutex> lock(mLock);
    mAttentionState = state;
    setSpeakerBatteryLightLocked();
}

void Light::setBacklight(const LightState& state) {
    std::lock_guard<std::mutex> lock(mLock);

    char val[12+1];
    snprintf(val, sizeof(val), "%u", rgbToBrightness(state));
    write_file(lcd_backlight_filename, val);
}

void Light::setBatteryLight(const LightState& state) {
    std::lock_guard<std::mutex> lock(mLock);
    mBatteryState = state;
    setSpeakerBatteryLightLocked();
}

void Light::setNotificationLight(const LightState& state) {
    std::lock_guard<std::mutex> lock(mLock);
    mNotificationState = state;
    setSpeakerBatteryLightLocked();
}

void Light::setSpeakerBatteryLightLocked() {
    if (isLit(mNotificationState)) {
        setSpeakerLightLocked(mNotificationState);
    } else if (isLit(mAttentionState)) {
        setSpeakerLightLocked(mAttentionState);
    } else if (isLit(mBatteryState)) {
        setSpeakerLightLocked(mBatteryState);
    } else {
        /* Lights off */
        LightState state;
        memset(&state, 0, sizeof(state));
        setSpeakerLightLocked(state);
    }
}

/*
 * The AW2013 driver reads 4 values from color/led_time:
 *   rise_time, hold_time, fall_time, off_time
 * Units for rise_time and fall_time are roughly 1/2 second.
 * Units for hold_time and off_time are roughly 1/4 second.
 * Note we hard code rise_time and fall_time to 1.
 *
 * Only one color may be active at a time, and only one mode (solid
 * or blinking).  Blinking is always at full brightness.
 */
void Light::setSpeakerLightLocked(const LightState& state) {
    int i;

    int color_idx = -1;
    uint32_t color_val = 0;
    for (i = 0; i < 3; ++i) {
        uint32_t val = (state.color >> ((2-i)*8)) & 0xff;
        if (val > color_val) {
            color_idx = i;
            color_val = val;
        }
    }
    bool flash = (state.flashMode == Flash::TIMED);
    uint32_t hold_time = state.flashOnMs / 250;
    uint32_t off_time = state.flashOffMs / 250;

    if (color_idx < 0 || color_val == 0) {
        for (i = 0; i < 3; ++i) {
            char pathname[80];
            snprintf(pathname, sizeof(pathname),
                    LED_BRIGHTNESS_FMT, COLOR_STR[i]);
            write_file(pathname, "0");
        }
    }
    else {
        char pathname[80];
        char val_str[40];
        if (flash) {
            snprintf(pathname, sizeof(pathname),
                    LED_BLINK_TIME_FMT, COLOR_STR[color_idx]);
            snprintf(val_str, sizeof(val_str),
                    "2 %u 2 %u", hold_time, off_time);
            write_file(pathname, val_str);
            snprintf(pathname, sizeof(pathname),
                    LED_BLINK_FMT, COLOR_STR[color_idx]);
            write_file(pathname, "1");
        }
        else {
            snprintf(pathname, sizeof(pathname),
                    LED_BRIGHTNESS_FMT, COLOR_STR[color_idx]);
            snprintf(val_str, sizeof(val_str),
                    "%u", color_val);
            write_file(pathname, val_str);
        }
    }
}

} // namespace implementation
}  // namespace V2_0
}  // namespace light
}  // namespace hardware
}  // namespace android
