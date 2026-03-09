#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 Recovery Tree Rebuild for Infinix X695C
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

# ============================================================================
# INIT LIBRARY
# ============================================================================
ifeq ($(TARGET_INIT_VENDOR_LIB),libinit_X695C)
include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libinit_X695C
LOCAL_C_INCLUDES := system/core/init
LOCAL_CFLAGS := -Wall -Werror
LOCAL_SRC_FILES := init/init_X695C.cpp
LOCAL_STATIC_LIBRARIES := libbase
LOCAL_POST_INSTALL_CMD := echo "Building init library for X695C"
include $(BUILD_STATIC_LIBRARY)
endif

# ============================================================================
# BOOT CONTROL HAL (MTK Implementation)
# ============================================================================
include $(CLEAR_VARS)
LOCAL_MODULE := android.hardware.boot@1.1-mtkimpl
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

# ============================================================================
# MTK PLPATH UTILS
# ============================================================================
include $(CLEAR_VARS)
LOCAL_MODULE := mtk_plpath_utils
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_TAGS := optional
include $(BUILD_EXECUTABLE)
