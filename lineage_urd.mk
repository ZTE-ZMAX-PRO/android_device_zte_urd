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

# Boot animation
TARGET_BOOTANIMATION_HALF_RES := true
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Inherit device configuration
$(call inherit-product, device/zte/urd/full_urd.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := urd
PRODUCT_NAME := lineage_urd
PRODUCT_BRAND := ZTE
PRODUCT_MODEL := Z981
PRODUCT_MANUFACTURER := ZTE

PRODUCT_GMS_CLIENTID_BASE := android-zte

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="P895T20_MPCS-user 6.0.1 MMB29M 20170802.130758 release-keys"
    
BUILD_FINGERPRINT := ZTE/P895T20_MPCS/urd:6.0.1/MMB29M/20170802.130758:user/release-keys

# Release name
PRODUCT_RELEASE_NAME := urd
