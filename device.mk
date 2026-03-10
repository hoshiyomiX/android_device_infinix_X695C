#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 Recovery Tree Rebuild for Infinix X695C
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/infinix/x695c

# ============================================================================
# A/B OTA CONFIGURATION
# ============================================================================
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    system \
    vendor \
    product \
    system_ext \
    boot \
    vbmeta \
    vbmeta_vendor \
    vbmeta_system

# A/B Postinstall Configuration
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# ============================================================================
# OTA PACKAGES
# ============================================================================
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# ============================================================================
# DYNAMIC PARTITIONS
# ============================================================================
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# ============================================================================
# API & VNDK
# ============================================================================
PRODUCT_TARGET_VNDK_VERSION := 30
PRODUCT_SHIPPING_API_LEVEL := 30

# ============================================================================
# SECURITY PATCH OVERRIDE (Anti-rollback bypass)
# ============================================================================
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.security_patch=2099-12-31

# ============================================================================
# BOOT CONTROL HAL (MTK Implementation for A/B)
# ============================================================================
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-mtkimpl \
    android.hardware.boot@1.1-mtkimpl.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctrl

# ============================================================================
# FASTBOOTD
# ============================================================================
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# ============================================================================
# MTK PLPATH UTILS (for dynamic partitions)
# ============================================================================
PRODUCT_PACKAGES += \
    mtk_plpath_utils \
    mtk_plpath_utils.recovery

# ============================================================================
# ADDITIONAL LIBRARIES FOR FBE CRYPTO
# ============================================================================
TARGET_RECOVERY_DEVICE_MODULES += \
    libkeymaster4 \
    libkeymaster4support \
    libkeymaster_messages \
    libkeymaster_portable \
    libpuresoftkeymasterdevice \
    libhwbinder \
    libhidltransport

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4support.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster_messages.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster_portable.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libhwbinder.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libhidltransport.so

# ============================================================================
# VENDOR BLOBS - Keymaster/Gatekeeper (FBE Decryption)
# ============================================================================
# Keymaster libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/libkeymaster4.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libkeymaster4.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/libkeymaster4support.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libkeymaster4support.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/libkeymaster_messages.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libkeymaster_messages.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/libkeymaster_portable.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libkeymaster_portable.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/libpuresoftkeymasterdevice.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libpuresoftkeymasterdevice.so

# Keymaster attestation (MediaTek)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/vendor.mediatek.hardware.keymaster_attestation@1.0.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.mediatek.hardware.keymaster_attestation@1.0.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/vendor.mediatek.hardware.keymaster_attestation@1.1.so:$(TARGET_COPY_OUT_VENDOR)/lib64/vendor.mediatek.hardware.keymaster_attestation@1.1.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/hw/vendor.mediatek.hardware.keymaster_attestation@1.1-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/vendor.mediatek.hardware.keymaster_attestation@1.1-impl.so

# Gatekeeper HAL
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/hw/android.hardware.gatekeeper@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/android.hardware.gatekeeper@1.0-impl.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/hw/gatekeeper.beanpod.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/gatekeeper.beanpod.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/hw/kmsetkey.beanpod.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/kmsetkey.beanpod.so

# Keymaster service (Beanpod - MediaTek TEE)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor/infinix/x695c/bin/hw/android.hardware.keymaster@4.0-service.beanpod:$(TARGET_COPY_OUT_VENDOR)/bin/hw/android.hardware.keymaster@4.0-service.beanpod \
    $(LOCAL_PATH)/vendor/infinix/x695c/bin/hw/android.hardware.gatekeeper@1.0-service:$(TARGET_COPY_OUT_VENDOR)/bin/hw/android.hardware.gatekeeper@1.0-service

# Service RC files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor/infinix/x695c/etc/init/android.hardware.keymaster@4.0-service.beanpod.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.keymaster@4.0-service.beanpod.rc \
    $(LOCAL_PATH)/vendor/infinix/x695c/etc/init/android.hardware.gatekeeper@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.gatekeeper@1.0-service.rc

# ============================================================================
# VENDOR BLOBS - HIDL/HwBinder (HAL Communication)
# ============================================================================
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/libhwbinder.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libhwbinder.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/libhidltransport.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libhidltransport.so

# ============================================================================
# VENDOR BLOBS - Display/Graphics (Recovery UI)
# ============================================================================
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/hw/gralloc.default.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/gralloc.default.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/hw/android.hardware.graphics.mapper@4.0-impl-mediatek.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/android.hardware.graphics.mapper@4.0-impl-mediatek.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/hw/android.hardware.graphics.allocator@4.0-impl-mediatek.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/android.hardware.graphics.allocator@4.0-impl-mediatek.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/hw/hwcomposer.mt6785.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/hwcomposer.mt6785.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/hw/memtrack.mt6785.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/memtrack.mt6785.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/hw/android.hardware.memtrack@1.0-impl.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/android.hardware.memtrack@1.0-impl.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/libgralloc_extra.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgralloc_extra.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/libgralloc_metadata.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgralloc_metadata.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/libgralloctypes_mtk.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libgralloctypes_mtk.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/libdrm.so:$(TARGET_COPY_OUT_VENDOR)/lib64/libdrm.so \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/android.hardware.graphics.composer@2.1-resources.so:$(TARGET_COPY_OUT_VENDOR)/lib64/android.hardware.graphics.composer@2.1-resources.so

# ============================================================================
# VENDOR BLOBS - Vibrator HAL (Haptic Feedback)
# ============================================================================
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/hw/vibrator.default.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/vibrator.default.so

# ============================================================================
# VENDOR BLOBS - Lights HAL (Brightness Control)
# ============================================================================
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor/infinix/x695c/lib64/hw/lights.mt6785.so:$(TARGET_COPY_OUT_VENDOR)/lib64/hw/lights.mt6785.so

# ============================================================================
# VENDOR BLOBS - Touch Firmware
# ============================================================================
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor/infinix/x695c/firmware/gt9886_firmware_6785a4.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/gt9886_firmware_6785a4.bin \
    $(LOCAL_PATH)/vendor/infinix/x695c/firmware/gt9886_firmware_6785ae.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/gt9886_firmware_6785ae.bin \
    $(LOCAL_PATH)/vendor/infinix/x695c/firmware/gt9886_cfg_6785v96.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/gt9886_cfg_6785v96.bin \
    $(LOCAL_PATH)/vendor/infinix/x695c/firmware/gt9886_cfg_6785v99.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/gt9886_cfg_6785v99.bin \
    $(LOCAL_PATH)/vendor/infinix/x695c/firmware/novatek_ts_fw.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/novatek_ts_fw.bin

# ============================================================================
# VINTF Manifest
# ============================================================================
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/vendor/infinix/x695c/etc/vintf/manifest.xml:$(TARGET_COPY_OUT_VENDOR)/etc/vintf/manifest.xml
