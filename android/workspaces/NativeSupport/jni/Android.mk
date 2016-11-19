LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := NativeSupport
LOCAL_SRC_FILES := NativeSupport.cpp

include $(BUILD_SHARED_LIBRARY)
