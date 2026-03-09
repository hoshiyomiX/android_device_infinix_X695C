# Recovery Tree Build Guide - Infinix X695C

## Quick Start

### 1. Download Prebuilt Files

Before building, you need to download the kernel and DTB files:

```bash
cd X695C-recovery-tree
bash download-prebuilts.sh
```

This will download:
- `prebuilt/kernel` - Prebuilt kernel from stock firmware
- `prebuilt/dtb.img` - Device Tree Blob

### 2. Setup TWRP Source

```bash
# Create working directory
mkdir -p ~/twrp && cd ~/twrp

# Initialize TWRP manifest (Android 11 / TWRP 12.1)
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1

# Sync source (this will take a while)
repo sync -j$(nproc --all)
```

### 3. Clone Device Tree

```bash
# Copy or clone the device tree
cp -r /path/to/X695C-recovery-tree ~/twrp/device/infinix/X695C

# Or clone from git
cd ~/twrp
git clone YOUR_REPO_URL device/infinix/X695C
```

### 4. Build Recovery

```bash
cd ~/twrp

# Setup environment
source build/envsetup.sh

# Lunch device
lunch omni_X695C-eng

# Build recovery
mka recoveryimage
```

### 5. Flash Recovery

```bash
# Boot to fastboot
adb reboot bootloader

# Flash recovery (A/B device uses boot partition)
fastboot flash boot_a out/target/product/X695C/boot.img
fastboot flash boot_b out/target/product/X695C/boot.img

# Reboot to recovery
fastboot reboot recovery
```

## Build Variants

### TWRP (Default)
```bash
lunch omni_X695C-eng
mka recoveryimage
```

### OrangeFox
For OrangeFox recovery, you need to sync OrangeFox source instead:

```bash
# Initialize OrangeFox manifest
repo init -u https://gitlab.com/OrangeFox/Manifest.git -b fox_12.1

# Then copy device tree and build
```

## Troubleshooting

### Build Errors

**Error: "libinit_X695C not found"**
- Make sure init/ directory exists with init_X695C.cpp
- Check Android.bp in init/ is correct

**Error: "kernel not found"**
- Run download-prebuilts.sh first
- Or extract kernel from stock boot.img manually

**Error: "dtb.img not found"**
- Run download-prebuilts.sh
- Or extract DTB from stock boot.img/dtbo.img

### Recovery Issues

**Black screen on boot**
- Check kernel and DTB are correct
- Verify boot image header version is 2

**Touch not working**
- Check if correct touch driver is in kernel
- May need to update kernel from newer firmware

**Encryption not working**
- Verify FBE configuration in BoardConfig.mk
- Check if vendor keymaster is correctly extracted

## File Checksums

After downloading prebuilts, verify files:

```bash
# Check kernel
file prebuilt/kernel
# Should show: Linux kernel ARM64 boot executable Image

# Check DTB
file prebuilt/dtb.img
# Should show: Device Tree Blob version X
```

## Additional Resources

- [TWRP Documentation](https://twrp.me/android/)
- [Android Building Guide](https://source.android.com/setup/build)
- [MediaTek Platform Development](https://forum.xda-developers.com/f/mediatek-cross-platform-development.10829/)
