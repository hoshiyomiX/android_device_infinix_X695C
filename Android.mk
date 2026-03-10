#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 Recovery Tree Rebuild for Infinix X695C
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

# This Android.mk is intentionally minimal.
# All modules are defined in subdirectory Android.bp files:
# - init/Android.bp: libinit_x695c
# - bootctrl/Android.bp: boot control HAL modules
# - mtk_plpath_utils/Android.bp: mtk_plpath_utils modules
