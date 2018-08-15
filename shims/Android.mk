LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    Fence.cpp

LOCAL_MODULE := libshim_camera
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true

LOCAL_32_BIT_ONLY := true

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
  gps_shim.cpp

LOCAL_MODULE := libshim_gps
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := atomic.cpp
LOCAL_MODULE := libshim_atomic
LOCAL_MODULE_TAGS := optional
LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_SHARED_LIBRARY)
