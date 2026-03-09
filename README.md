# TWRP Device Tree for Infinix X695C

[![TWRP](https://img.shields.io/badge/TWRP-11-blue.svg)](https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp)
[![Device](https://img.shields.io/badge/Device-X695C-green.svg)]()
[![Platform](https://img.shields.io/badge/Platform-MT6785-orange.svg)]()

TWRP recovery device tree for **Infinix Note 10 Pro (X695C)** - MediaTek MT6785 (Helio G95)

---

## 📱 Device Information

| Property | Value |
|----------|-------|
| **Device** | Infinix X695C |
| **Codename** | x695c |
| **Marketing Name** | Infinix Note 10 Pro |
| **Manufacturer** | INFINIX MOBILITY LIMITED |
| **Platform** | MediaTek MT6785 (Helio G95) |
| **Android Version** | 11 (RP1A.200720.011) |
| **Kernel Version** | 4.14.186 |
| **A/B Device** | Yes (Virtual A/B) |
| **Treble** | Yes |
| **Dynamic Partitions** | Yes |
| **Encryption** | FBE (File-Based Encryption) |

---

## ✅ Recovery Features

| Feature | Status |
|---------|--------|
| Touch Support | ✅ Working |
| Display/Graphics | ✅ Working |
| Brightness Control | ✅ Working |
| Vibrator | ✅ Working |
| FBE Decryption | ✅ Working |
| MTP | ✅ Working |
| USB Mass Storage | ✅ Working |
| A/B Slot Switch | ✅ Working |
| Fastbootd | ✅ Working |
| Backup/Restore | ✅ Working |

---

## 🚀 Building TWRP

### Prerequisites
- Ubuntu 20.04+ or similar Linux distribution
- 16 GB+ RAM recommended
- 200 GB+ free disk space

### Build Steps

```bash
# 1. Initialize TWRP source
mkdir -p ~/twrp && cd ~/twrp
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-11
repo sync -j$(nproc --all)

# 2. Clone device tree (lowercase path)
git clone https://github.com/hoshiyomiX/android_device_infinix_x695c.git device/infinix/x695c

# 3. Build
source build/envsetup.sh
lunch omni_x695c-eng
mka bootimage

# 4. Output location
# out/target/product/x695c/boot.img
```

### Flashing Recovery

```bash
# Boot to fastboot mode
adb reboot bootloader

# Flash recovery (A/B device - flash both slots)
fastboot flash boot_a boot.img
fastboot flash boot_b boot.img

# Or flash to active slot only
fastboot flash boot boot.img

# Reboot to recovery
fastboot reboot recovery
```

---

## 📁 Directory Structure

```
device/infinix/x695c/
├── AndroidProducts.mk      # Product definitions
├── BoardConfig.mk          # Board configuration
├── device.mk               # Device-specific config
├── omni_x695c.mk          # TWRP product makefile
├── system.prop             # System properties
├── recovery.fstab          # Partition definitions
├── vendorsetup.sh          # Lunch combo setup
├── prebuilt/
│   ├── kernel              # Stock kernel (10 MB)
│   └── dtb.img             # Device tree blob (157 KB)
├── init/
│   ├── Android.bp
│   └── init_x695c.cpp     # Property override
├── bootctrl/               # A/B boot control HAL
├── mtk_plpath_utils/       # Dynamic partition utils
└── vendor/infinix/x695c/   # Vendor blobs
    ├── lib64/              # Libraries
    │   ├── libkeymaster4.so
    │   ├── libkeymaster4support.so
    │   ├── libkeymaster_messages.so
    │   ├── libkeymaster_portable.so
    │   ├── libpuresoftkeymasterdevice.so
    │   ├── libhwbinder.so
    │   ├── libhidltransport.so
    │   ├── libdrm.so
    │   ├── libgralloc_*.so
    │   └── hw/
    │       ├── android.hardware.gatekeeper@1.0-impl.so
    │       ├── android.hardware.graphics.*.so
    │       ├── hwcomposer.mt6785.so
    │       ├── memtrack.mt6785.so
    │       ├── lights.mt6785.so
    │       └── vibrator.default.so
    ├── firmware/           # Touch firmware
    │   ├── gt9886_firmware_*.bin
    │   ├── gt9886_cfg_*.bin
    │   └── novatek_ts_fw.bin
    └── etc/vintf/
        └── manifest.xml
```

---

## 📦 Included Blobs

### FBE Decryption (Keymaster/Gatekeeper)
- `libkeymaster4.so`
- `libkeymaster4support.so`
- `libkeymaster_messages.so`
- `libkeymaster_portable.so`
- `libpuresoftkeymasterdevice.so`
- `android.hardware.gatekeeper@1.0-impl.so`

### Display/Graphics
- `gralloc.default.so`
- `android.hardware.graphics.mapper@4.0-impl-mediatek.so`
- `android.hardware.graphics.allocator@4.0-impl-mediatek.so`
- `hwcomposer.mt6785.so`
- `memtrack.mt6785.so`
- `libgralloc_*.so`
- `libdrm.so`

### Touch Firmware
- Goodix GT9886 firmware
- Novatek touch firmware

---

## 📊 Size

| Component | Size |
|-----------|------|
| Kernel + DTB | ~10.2 MB |
| Vendor blobs | ~2.3 MB |
| Config files | ~50 KB |
| **Total** | **~12.5 MB** |

---

## 📜 Credits

- **Firmware dump**: [GitLab](https://gitlab.com/excaliburXD/android_dump_INFINIX_Infinix-X695C)
- **TWRP team**: [Team Win](https://teamwin.me/)
- **Minimal TWRP manifest**: [minimal-manifest-twrp](https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp)

---

## 📄 License

```
Copyright (C) 2024
Licensed under the Apache License, Version 2.0
SPDX-License-Identifier: Apache-2.0
```
