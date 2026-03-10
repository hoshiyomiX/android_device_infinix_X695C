#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 OrangeFox Recovery Tree for Infinix X695C
#
# SPDX-License-Identifier: Apache-2.0
#

# ============================================================================
# DEVICE PATH
# ============================================================================
DEVICE_PATH := device/infinix/x695c

# ============================================================================
# MINIMAL DEPENDENCIES
# ============================================================================
ALLOW_MISSING_DEPENDENCIES := true

# ============================================================================
# ARCHITECTURE
# ============================================================================
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_USES_64_BIT_BINDER := true

# ============================================================================
# A/B OTA
# ============================================================================
AB_OTA_UPDATER := true

# ============================================================================
# ASSERT
# ============================================================================
TARGET_OTA_ASSERT_DEVICE := X695C,X695,X695D,Infinix-X695C

# ============================================================================
# BOOTLOADER
# ============================================================================
TARGET_BOOTLOADER_BOARD_NAME := mt6785
TARGET_NO_BOOTLOADER := true

# ============================================================================
# BUILD HACKS (for older recovery compatibility)
# ============================================================================
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true

# ============================================================================
# KERNEL CONFIGURATION
# ============================================================================
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000
BOARD_SECOND_OFFSET := 0xbff88000
BOARD_DTB_OFFSET := 0x0bc08000
BOARD_KERNEL_IMAGE_NAME := kernel

TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img

BOARD_MKBOOTIMG_ARGS += \
    --header_version $(BOARD_BOOT_HEADER_VERSION) \
    --pagesize $(BOARD_KERNEL_PAGESIZE) \
    --board "" \
    --kernel_offset $(BOARD_KERNEL_OFFSET) \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --second_offset $(BOARD_SECOND_OFFSET) \
    --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) \
    --dtb_offset $(BOARD_DTB_OFFSET) \
    --dtb $(TARGET_PREBUILT_DTB)

# ============================================================================
# ANDROID VERIFIED BOOT (AVB)
# ============================================================================
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# ============================================================================
# PARTITION SIZES
# ============================================================================
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_USES_METADATA_PARTITION := true

BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_COPY_OUT_SYSTEM := system
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

# ============================================================================
# DYNAMIC PARTITIONS
# ============================================================================
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_SIZE := 9122611200
BOARD_MAIN_PARTITION_LIST := system vendor product system_ext

# ============================================================================
# RECOVERY CONFIGURATION
# ============================================================================
BOARD_SUPPRESS_SECURE_ERASE := true
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_NO_REAL_SDCARD := true

RECOVERY_SDCARD_ON_DATA := true

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USES_MKE2FS := true
TARGET_NO_RECOVERY := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab

# ============================================================================
# PLATFORM
# ============================================================================
TARGET_BOARD_PLATFORM := mt6785

# ============================================================================
# ORANGEFOX CRYPTO (File-Based Encryption A11+)
# ============================================================================
OF_DEVICE_ENCRYPTION := true
OF_FBE_CONFIG := true
OF_LEGACY_CRYPTO := false
OF_RUN_KEYMASTER_VIA_QSEE := false
OF_SUPPORT_ALL_BLOCK_UEVENTS := true

# OrangeFox FBE decryption libraries
TARGET_RECOVERY_DEVICE_MODULES += \
    libkeymaster4 \
    libkeymaster4support \
    libkeymaster_messages \
    libkeymaster_portable \
    libpuresoftkeymasterdevice \
    libhwbinder \
    libhidltransport

# ============================================================================
# ANTI-ROLLBACK BYPASS (Hack)
# ============================================================================
PLATFORM_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 11.0.0
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# ============================================================================
# ORANGEFOX TOOLS
# ============================================================================
OF_USE_LZMA_RECOVERY := true
OF_USE_MAGISKBOOT_FOR_ALL_PATCHES := true
OF_NO_TREBLE_COMPAT_CHECK := true
OF_SKIP_MULTIUSER_FOLDERS_BACKUP := true

# ============================================================================
# ORANGEFOX UI CONFIGURATION
# ============================================================================
OF_SCREEN_H := 2460
OF_SCREEN_W := 1080
OF_DPI := 400
OF_STATUS_H := 40
OF_STATUS_INDENT := 40
OF_CLOCK_POS := 300

# Hide not needed items
OF_HIDE_REPACK_MENU := false
OF_HIDE_ADB_SIDEBAR := false

# ============================================================================
# ORANGEFOX MAINTAINER
# ============================================================================
OF_MAINTAINER := hoshiyomiX

# ============================================================================
# DEBUG
# ============================================================================
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
