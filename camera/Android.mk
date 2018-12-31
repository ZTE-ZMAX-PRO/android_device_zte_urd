LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := camera.$(TARGET_BOARD_PLATFORM)
LOCAL_SRC_FILES := CameraWrapper.cpp

LOCAL_C_INCLUDES := \
    system/media/camera/include

LOCAL_STATIC_LIBRARIES := \
    libbase libarect

LOCAL_HEADER_LIBRARIES += \
    libnativebase_headers

LOCAL_SHARED_LIBRARIES := \
    libhardware liblog libcamera_client libutils libcutils libdl \
    android.hidl.token@1.0-utils \
    android.hardware.graphics.bufferqueue@1.0

LOCAL_MULTILIB := 32
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_CFLAGS := -Werror
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_SHARED_LIBRARY)
