#!/bin/bash
#
# Download prebuilt kernel, DTB and essential vendor blobs
# from GitLab firmware dump repository
#

set -e

# Repository info
REPO="excaliburXD/android_dump_INFINIX_Infinix-X695C"
BRANCH="RP1A.200720.011"

API_URL="https://gitlab.com/api/v4/projects/excaliburXD%2Fandroid_dump_INFINIX_Infinix-X695C/repository/files"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BASE_DIR="${SCRIPT_DIR}"
PREBUILT_DIR="${BASE_DIR}/prebuilt"
VENDOR_DIR="${BASE_DIR}/vendor/infinix/X695C"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}=== Infinix X695C Recovery Tree Downloder ===${NC}"
echo ""

# Create directories
mkdir -p "${PREBUILT_DIR}"
mkdir -p "${VENDOR_DIR}"/{bin/hw,lib/{hw,drm,mediadrm,soundfx},lib64/{hw,drm,mediadrm,soundfx},etc/{init,vintf,audio_param}}

mkdir -p "${BASE_DIR}/logs"

# Download function
dl() {
    local src="$1"
    local dst="$2"
    local enc_path
    
    enc_path=$(echo "$src" | sed 's/\//%2F/g')
    mkdir -p "$(dirname "$dst")"
    
    echo -ne "  Downloading: $src                                    "
    if curl -sL "${API_URL}/${enc_path}/raw?ref=${BRANCH}" -o "$dst" 2>/dev/null; then
        if [ -s "$dst" ]; then
            echo -e "${GREEN}✓ $src${NC}"
            return 0
        fi
    fi
    
    echo -e "${RED}✗ $src (failed)${NC}"
    rm -f "$dst"
    return 1
}

echo ""
echo "=== Step 1: Downloading Prebuilt Kernel & DTB ==="
echo ""

# Download kernel
dl "twrp-device-tree/Infinix-X695C/prebuilt/kernel" "${PREBUILT_DIR}/kernel"

# Download DTB
dl "twrp-device-tree/Infinix-X695C/prebuilt/dtb.img" "${PREBUILT_DIR}/dtb.img"

echo ""
echo "=== Step 2: Downloading Keymaster Blobs (FBE Decryption) ==="
echo ""

# Keymaster - Critical for FBE decryption
dl "vendor/lib/libkeymaster4.so" "${VENDOR_DIR}/lib/libkeymaster4.so"
dl "vendor/lib64/libkeymaster4.so" "${VENDOR_DIR}/lib64/libkeymaster4.so"
dl "vendor/lib/libkeymaster_messages.so" "${VENDOR_DIR}/lib/libkeymaster_messages.so"
dl "vendor/lib64/libkeymaster_messages.so" "${VENDOR_DIR}/lib64/libkeymaster_messages.so"
dl "vendor/lib/libpuresoftkeymasterdevice.so" "${VENDOR_DIR}/lib/libpuresoftkeymasterdevice.so"
dl "vendor/lib64/libpuresoftkeymasterdevice.so" "${VENDOR_DIR}/lib64/libpuresoftkeymasterdevice.so"
dl "vendor/lib/hw/android.hardware.keymaster@4.0-impl.so" "${VENDOR_DIR}/lib/hw/android.hardware.keymaster@4.0-impl.so"
dl "vendor/lib64/hw/android.hardware.keymaster@4.0-impl.so" "${VENDOR_DIR}/lib64/hw/android.hardware.keymaster@4.0-impl.so"

echo ""
echo "=== Step 3: Downloading Gatekeeper Blobs ==="
echo ""

# Gatekeeper
dl "vendor/lib/libgatekeeper.so" "${VENDOR_DIR}/lib/libgatekeeper.so"
dl "vendor/lib64/libgatekeeper.so" "${VENDOR_DIR}/lib64/libgatekeeper.so"
dl "vendor/lib/hw/android.hardware.gatekeeper@1.0-impl.so" "${VENDOR_DIR}/lib/hw/android.hardware.gatekeeper@1.0-impl.so"
dl "vendor/lib64/hw/android.hardware.gatekeeper@1.0-impl.so" "${VENDOR_DIR}/lib64/hw/android.hardware.gatekeeper@1.0-impl.so"

echo ""
echo "=== Step 4: Downloading Boot Control Blobs ==="
echo ""

# Boot Control - For A/B slot switching
dl "vendor/lib/hw/android.hardware.boot@1.1-impl.so" "${VENDOR_DIR}/lib/hw/android.hardware.boot@1.1-impl.so"
dl "vendor/lib64/hw/android.hardware.boot@1.1-impl.so" "${VENDOR_DIR}/lib64/hw/android.hardware.boot@1.1-impl.so"

echo ""
echo "=== Step 5: Downloading Audio Blobs ==="
echo ""

# Audio HAL
dl "vendor/bin/hw/android.hardware.audio.service.mediatek" "${VENDOR_DIR}/bin/hw/android.hardware.audio.service.mediatek"
dl "vendor/lib/hw/android.hardware.audio.effect@6.0-impl.so" "${VENDOR_DIR}/lib/hw/android.hardware.audio.effect@6.0-impl.so"
dl "vendor/lib/hw/audio.primary.mt6785.so" "${VENDOR_DIR}/lib/hw/audio.primary.mt6785.so"
dl "vendor/lib64/hw/android.hardware.audio.effect@6.0-impl.so" "${VENDOR_DIR}/lib64/hw/android.hardware.audio.effect@6.0-impl.so"
dl "vendor/lib64/hw/audio.primary.mt6785.so" "${VENDOR_DIR}/lib64/hw/audio.primary.mt6785.so"
dl "vendor/lib/libaudiocustparam_vendor.so" "${VENDOR_DIR}/lib/libaudiocustparam_vendor.so"
dl "vendor/lib64/libaudiocustparam_vendor.so" "${VENDOR_DIR}/lib64/libaudiocustparam_vendor.so"
dl "vendor/lib/vendor.mediatek.hardware.audio@6.1.so" "${VENDOR_DIR}/lib/vendor.mediatek.hardware.audio@6.1.so"
dl "vendor/lib64/vendor.mediatek.hardware.audio@6.1.so" "${VENDOR_DIR}/lib64/vendor.mediatek.hardware.audio@6.1.so"

echo ""
echo "=== Step 6: Downloading Display/Graphics Blobs ==="
echo ""

# Display/Graphics
dl "vendor/lib/libui.so" "${VENDOR_DIR}/lib/libui.so"
dl "vendor/lib64/libui.so" "${VENDOR_DIR}/lib64/libui.so"
dl "vendor/lib/libgui.so" "${VENDOR_DIR}/lib/libgui.so"
dl "vendor/lib64/libgui.so" "${VENDOR_DIR}/lib64/libgui.so"
dl "vendor/lib/hw/gralloc.mt6785.so" "${VENDOR_DIR}/lib/hw/gralloc.mt6785.so"
dl "vendor/lib64/hw/gralloc.mt6785.so" "${VENDOR_DIR}/lib64/hw/gralloc.mt6785.so"
dl "vendor/lib/hw/android.hardware.graphics.allocator@2.0-impl.so" "${VENDOR_DIR}/lib/hw/android.hardware.graphics.allocator@2.0-impl.so"
dl "vendor/lib64/hw/android.hardware.graphics.allocator@2.0-impl.so" "${VENDOR_DIR}/lib64/hw/android.hardware.graphics.allocator@2.0-impl.so"
dl "vendor/lib/hw/android.hardware.graphics.mapper@2.0-impl.so" "${VENDOR_DIR}/lib/hw/android.hardware.graphics.mapper@2.0-impl.so"
dl "vendor/lib64/hw/android.hardware.graphics.mapper@2.0-impl.so" "${VENDOR_DIR}/lib64/hw/android.hardware.graphics.mapper@2.0-impl.so"

echo ""
echo "=== Step 7: Downloading Media/OMX Blobs ==="
echo ""

# Media/OMX
dl "vendor/lib/libstagefrighthw.so" "${VENDOR_DIR}/lib/libstagefrighthw.so"
dl "vendor/lib64/libstagefrighthw.so" "${VENDOR_DIR}/lib64/libstagefrighthw.so"
dl "vendor/lib/libMtkOmxCore.so" "${VENDOR_DIR}/lib/libMtkOmxCore.so"
dl "vendor/lib64/libMtkOmxCore.so" "${VENDOR_DIR}/lib64/libMtkOmxCore.so"
dl "vendor/lib/libMtkOmxVdec.so" "${VENDOR_DIR}/lib/libMtkOmxVdec.so"
dl "vendor/lib64/libMtkOmxVdec.so" "${VENDOR_DIR}/lib64/libMtkOmxVdec.so"
dl "vendor/lib/libMtkOmxVenc.so" "${VENDOR_DIR}/lib/libMtkOmxVenc.so"
dl "vendor/lib64/libMtkOmxVenc.so" "${VENDOR_DIR}/lib64/libMtkOmxVenc.so"

echo ""
echo "=== Step 8: Downloading DRM Blobs ==="
echo ""

# DRM
dl "vendor/lib/mediadrm/libdrmclearkeyplugin.so" "${VENDOR_DIR}/lib/mediadrm/libdrmclearkeyplugin.so"
dl "vendor/lib64/mediadrm/libdrmclearkeyplugin.so" "${VENDOR_DIR}/lib64/mediadrm/libdrmclearkeyplugin.so"
dl "vendor/lib/libwvhidl.so" "${VENDOR_DIR}/lib/libwvhidl.so"
dl "vendor/lib64/libwvhidl.so" "${VENDOR_DIR}/lib64/libwvhidl.so"

echo ""
echo "=== Step 9: Downloading Bluetooth Blobs ==="
echo ""

# Bluetooth
dl "vendor/bin/hw/android.hardware.bluetooth@1.0-service-mediatek" "${VENDOR_DIR}/bin/hw/android.hardware.bluetooth@1.0-service-mediatek"
dl "vendor/lib/libbluetooth_mtk.so" "${VENDOR_DIR}/lib/libbluetooth_mtk.so"
dl "vendor/lib64/libbluetooth_mtk.so" "${VENDOR_DIR}/lib64/libbluetooth_mtk.so"

echo ""
echo "=== Step 10: Downloading Config Files ==="
echo ""

# Config files
dl "vendor/etc/audio_policy_configuration.xml" "${VENDOR_DIR}/etc/audio_policy_configuration.xml"
dl "vendor/etc/audio_effects.xml" "${VENDOR_DIR}/etc/audio_effects.xml"
dl "vendor/etc/media_codecs.xml" "${VENDOR_DIR}/etc/media_codecs.xml"
dl "vendor/etc/media_profiles.xml" "${VENDOR_DIR}/etc/media_profiles.xml"
dl "vendor/etc/fstab.mt6785" "${VENDOR_DIR}/etc/fstab.mt6785"
dl "vendor/etc/vintf/manifest.xml" "${VENDOR_DIR}/etc/vintf/manifest.xml"

echo ""
echo "=== Step 11: Downloading HIDL Libraries ==="
echo ""

# HIDL Libraries
dl "vendor/lib/libhwbinder.so" "${VENDOR_DIR}/lib/libhwbinder.so"
dl "vendor/lib64/libhwbinder.so" "${VENDOR_DIR}/lib64/libhwbinder.so"
dl "vendor/lib/libhidlbase.so" "${VENDOR_DIR}/lib/libhidlbase.so"
dl "vendor/lib64/libhidlbase.so" "${VENDOR_DIR}/lib64/libhidlbase.so"
dl "vendor/lib/libhidltransport.so" "${VENDOR_DIR}/lib/libhidltransport.so"
dl "vendor/lib64/libhidltransport.so" "${VENDOR_DIR}/lib64/libhidltransport.so"
dl "vendor/lib/android.hardware.common.base@1.0.so" "${VENDOR_DIR}/lib/android.hardware.common.base@1.0.so"
dl "vendor/lib64/android.hardware.common.base@1.0.so" "${VENDOR_DIR}/lib64/android.hardware.common.base@1.0.so"

echo ""
echo "=== Step 12: Downloading MTK Platform Libraries ==="
echo ""

# MTK Platform
dl "vendor/lib/libmtk_drv.so" "${VENDOR_DIR}/lib/libmtk_drv.so"
dl "vendor/lib64/libmtk_drv.so" "${VENDOR_DIR}/lib64/libmtk_drv.so"
dl "vendor/lib/libnvram.so" "${VENDOR_DIR}/lib/libnvram.so"
dl "vendor/lib64/libnvram.so" "${VENDOR_DIR}/lib64/libnvram.so"
dl "vendor/lib/libnvram_sec.so" "${VENDOR_DIR}/lib/libnvram_sec.so"
dl "vendor/lib64/libnvram_sec.so" "${VENDOR_DIR}/lib64/libnvram_sec.so"

echo ""
echo "=== Step 13: Downloading System Libraries ==="
echo ""

# System Libraries
dl "vendor/lib/libutils.so" "${VENDOR_DIR}/lib/libutils.so"
dl "vendor/lib64/libutils.so" "${VENDOR_DIR}/lib64/libutils.so"
dl "vendor/lib/libcutils.so" "${VENDOR_DIR}/lib/libcutils.so"
dl "vendor/lib64/libcutils.so" "${VENDOR_DIR}/lib64/libcutils.so"
dl "vendor/lib/liblog.so" "${VENDOR_DIR}/lib/liblog.so"
dl "vendor/lib64/liblog.so" "${VENDOR_DIR}/lib64/liblog.so"
dl "vendor/lib/libbase.so" "${VENDOR_DIR}/lib/libbase.so"
dl "vendor/lib64/libbase.so" "${VENDOR_DIR}/lib64/libbase.so"

echo ""
echo -e "${GREEN}===========================================${NC}"
echo -e "${GREEN}       DOWNLOAD COMPLETE!${NC}"
echo -e "${GREEN}===========================================${NC}"
echo ""
echo "All essential files have been downloaded for recovery tree."
echo ""
