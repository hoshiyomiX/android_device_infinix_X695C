# Infinix X695C Recovery Tree (Minimal)

Minimal device tree for building TWRP/OrangeFox recovery for Infinix X695C (Note 10 Pro).

## Device Information

| Property | Value |
|----------|-------|
| **Device** | Infinix X695C |
| **Codename** | Infinix-X695C |
| **Marketing Name** | Infinix Note 10 Pro |
| **Manufacturer** | INFINIX MOBILITY LIMITED |
| **Platform** | MediaTek MT6785 (Helio G95) |
| **Android Version** | 11 (RP1A.200720.011) |
| **Kernel Version** | 4.14.186 |
| **A/B Device** | Yes (Virtual A/B) |
| **Treble** | Yes |
| **Dynamic Partitions** | Yes |
| **File-Based Encryption** | Yes |

## What's Included (Essential Only)

This minimal recovery tree contains only essential blobs required for TWRP:

### Vendor Blobs (~300KB)
- `libkeymaster4.so` - For FBE decryption
- `libkeymaster_messages.so` - Keymaster support
- `libpuresoftkeymasterdevice.so` - Software keymaster
- `android.hardware.gatekeeper@1.0-impl.so` - Gatekeeper HAL
- `libhwbinder.so` - HIDL binder
- `libhidltransport.so` - HIDL transport

### Configuration Files
- `fstab.mt6785` - File system table
- `vintf/manifest.xml` - VINTF manifest

### Prebuilt Files (~9.7MB)
- `kernel` - Stock kernel (9.6MB)
- `dtb.img` - Device Tree Blob (154KB)

## What's NOT Included (Removed)

The following blobs have been removed as they are not required for recovery:
- ❌ Audio blobs
- ❌ Bluetooth blobs
- ❌ WiFi blobs
- ❌ Camera blobs
- ❌ GPS/GNSS blobs
- ❌ Sensor blobs
- ❌ Media/OMX blobs
- ❌ DRM/Widevine blobs
- ❌ RIL/Modem blobs
- ❌ Power/Thermal blobs
- ❌ Light/Vibrator blobs
- ❌ NVRAM blobs
- ❌ Touchscreen firmware (if separate)
- ❌ Fingerprint blobs

## File Structure

```
X695C-recovery-tree/
├── Android.bp
├── Android.mk
├── AndroidProducts.mk
├── BoardConfig.mk
├── device.mk
├── omni_X695C.mk
├── vendorsetup.sh
├── recovery.fstab
├── system.prop
├── proprietary-files.txt
├── download-prebuilts.sh
├── prebuilt/
│   ├── kernel              # 9.6MB
│   └── dtb.img             # 154KB
├── init/
│   ├── Android.bp
│   └── init_X695C.cpp
├── bootctrl/
│   ├── Android.bp
│   ├── BootControl.cpp
│   ├── BootControl.h
│   ├── boot_region_control.cpp
│   └── boot_region_control.h
├── mtk_plpath_utils/
│   ├── Android.bp
│   └── mtk_plpath_utils.cpp
├── recovery/root/
│   ├── init.recovery.mt6785.rc
│   └── system/etc/recovery.fstab
└── vendor/infinix/X695C/
    ├── Android.mk
    ├── lib64/
    │   ├── libkeymaster4.so
    │   ├── libkeymaster_messages.so
    │   ├── libpuresoftkeymasterdevice.so
    │   ├── libhwbinder.so
    │   ├── libhidltransport.so
    │   └── hw/
    │       └── android.hardware.gatekeeper@1.0-impl.so
    └── etc/
        ├── fstab.mt6785
        └── vintf/manifest.xml
```

## Building TWRP

### Prerequisites
- Ubuntu 20.04+ or similar
- 16 GB+ RAM
- 200 GB+ disk space

### Build Steps

```bash
# 1. Setup TWRP source
mkdir -p ~/twrp && cd ~/twrp
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
repo sync -j$(nproc --all)

# 2. Copy device tree
cp -r X695C-recovery-tree ~/twrp/device/infinix/X695C

# 3. Build
source build/envsetup.sh
lunch omni_X695C-eng
mka recoveryimage

# 4. Output
# out/target/product/X695C/boot.img
```

### Flashing

```bash
# Boot to fastboot
adb reboot bootloader

# Flash recovery (A/B device)
fastboot flash boot_a boot.img
fastboot flash boot_b boot.img

# Reboot to recovery
fastboot reboot recovery
```

## Size Comparison

| Version | Size |
|---------|------|
| Full blobs | ~100MB+ |
| **Minimal (this)** | **~11MB** |

## Credits

- Original firmware dump: [GitLab](https://gitlab.com/excaliburXD/android_dump_INFINIX_Infinix-X695C)
- TWRP team

## License

```
Copyright (C) 2024
Licensed under the Apache License, Version 2.0
```
