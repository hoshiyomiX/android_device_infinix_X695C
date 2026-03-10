#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 Recovery Tree Rebuild for Infinix X695C
#
# SPDX-License-Identifier: Apache-2.0
#

# ============================================================================
# INHERIT FROM THOSE PRODUCTS - Most specific first
# ============================================================================
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# ============================================================================
# INHERIT SOME COMMON TWRP STUFF
# ============================================================================
$(call inherit-product, vendor/twrp/config/common.mk)

# ============================================================================
# INHERIT FROM DEVICE
# ============================================================================
$(call inherit-product, device/infinix/x695c/device.mk)

# ============================================================================
# DEVICE IDENTIFIER
# ============================================================================
PRODUCT_DEVICE := x695c
PRODUCT_NAME := twrp_x695c
PRODUCT_BRAND := Infinix
PRODUCT_MODEL := Infinix X695C
PRODUCT_MANUFACTURER := INFINIX MOBILITY LIMITED

# GMS Client ID
PRODUCT_GMS_CLIENTID_BASE := android-transsion
