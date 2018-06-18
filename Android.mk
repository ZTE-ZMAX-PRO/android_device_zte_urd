#
# Copyright 2018 The LineageOS Project
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
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),urd)
include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

WCNSS_CFG_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/wlan/prima/WCNSS_qcom_cfg.ini
$(WCNSS_CFG_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@mkdir -p $(dir $@)
	$(hide) ln -sf /data/vendor/wifi/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WCNSS_CFG_SYMLINK)

# RFS symlinks
RFS_SYMLINKS := $(TARGET_OUT)/rfs
$(RFS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "RFS links"
	@rm -rf $(TARGET_OUT)/rfs 
	@mkdir -p $(TARGET_OUT)/rfs/apq/gnss/readonly
	$(hide) ln -sf /persist/hlos_rfs/shared $(TARGET_OUT)/rfs/apq/gnss/hlos
	$(hide) ln -sf /data/tombstones/lpass $(TARGET_OUT)/rfs/apq/gnss/ramdumps
	$(hide) ln -sf /persist/rfs/apq/gnss $(TARGET_OUT)/rfs/apq/gnss/readwrite
	$(hide) ln -sf /persist/rfs/shared $(TARGET_OUT)/rfs/apq/gnss/shared
	$(hide) ln -sf /firmware $(TARGET_OUT)/rfs/apq/gnss/readonly/firmware
	@mkdir -p $(TARGET_OUT)/rfs/msm/adsp/readonly
	$(hide) ln -sf /persist/hlos_rfs/shared $(TARGET_OUT)/rfs/msm/adsp/hlos
	$(hide) ln -sf /data/tombstones/lpass $(TARGET_OUT)/rfs/msm/adsp/ramdumps
	$(hide) ln -sf /persist/rfs/msm/adsp $(TARGET_OUT)/rfs/msm/adsp/readwrite
	$(hide) ln -sf /persist/rfs/shared $(TARGET_OUT)/rfs/msm/adsp/shared
	$(hide) ln -sf /firmware $(TARGET_OUT)/rfs/msm/adsp/readonly/firmware
	@mkdir -p $(TARGET_OUT)/rfs/msm/mpss/readonly
	$(hide) ln -sf /persist/hlos_rfs/shared $(TARGET_OUT)/rfs/msm/mpss/hlos
	$(hide) ln -sf /data/tombstones/lpass $(TARGET_OUT)/rfs/msm/mpss/ramdumps
	$(hide) ln -sf /persist/rfs/msm/mpss $(TARGET_OUT)/rfs/msm/mpss/readwrite
	$(hide) ln -sf /persist/rfs/shared $(TARGET_OUT)/rfs/msm/mpss/shared
	$(hide) ln -sf /firmware $(TARGET_OUT)/rfs/msm/mpss/readonly/firmware

ALL_DEFAULT_INSTALLED_MODULES += $(RFS_SYMLINKS)

endif
