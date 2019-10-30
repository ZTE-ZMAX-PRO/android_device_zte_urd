# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Arrow stuff.
$(call inherit-product, vendor/arrow/config/common.mk)

# Inherit device configuration
$(call inherit-product, device/zte/urd/device.mk)

# Boot animation
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 1920
TARGET_BOOTANIMATION_HALF_RES := true

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := urd
PRODUCT_NAME := arrow_urd
PRODUCT_RELEASE_NAME := urd
PRODUCT_BRAND := ZTE
PRODUCT_MANUFACTURER := ZTE

BOARD_VENDOR := ZTE

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="P895T20_MPCS-user 6.0.1 MMB29M 20170802.130758 release-keys" \

PRODUCT_ENFORCE_RRO_TARGETS := \
    framework-res
    
BUILD_FINGERPRINT := ZTE/P895T20_MPCS/urd:6.0.1/MMB29M/20170802.130758:user/release-keys
