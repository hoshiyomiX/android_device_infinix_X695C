#!/bin/bash
#
# Extract proprietary files from Infinix X695C device
# Run this script while device is connected via ADB
#

set -e

DEVICE=X695C
VENDOR=infinix
OUTDIR=vendor/$VENDOR/$DEVICE

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check ADB connection
check_adb() {
    if ! adb devices | grep -q "device$"; then
        echo -e "${RED}Error: No device connected via ADB${NC}"
        exit 1
    fi
}

# Extract single file
extract() {
    local src="$1"
    local dst="$2"
    
    mkdir -p "$(dirname "$dst")"
    
    if adb pull "$src" "$dst" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} $src"
    else
        echo -e "${RED}✗${NC} $src (failed)"
    fi
}

echo -e "${YELLOW}Extracting proprietary blobs from Infinix X695C...${NC}"
echo ""

check_adb

# Create output directory
mkdir -p "$OUTDIR/lib64/hw"

echo "=== Graphics Blobs ==="
extract "/vendor/lib64/hw/gralloc.mt6785.so" "$OUTDIR/lib64/hw/gralloc.mt6785.so"
extract "/vendor/lib64/libui.so" "$OUTDIR/lib64/libui.so"
extract "/vendor/lib64/libgui.so" "$OUTDIR/lib64/libgui.so"
extract "/vendor/lib64/libion.so" "$OUTDIR/lib64/libion.so"
extract "/vendor/lib64/libhidlbase.so" "$OUTDIR/lib64/libhidlbase.so"
extract "/vendor/lib64/libhwbinder.so" "$OUTDIR/lib64/libhwbinder.so"
extract "/vendor/lib64/libhidltransport.so" "$OUTDIR/lib64/libhidltransport.so"

echo ""
echo "=== Keymaster (FBE Decryption) ==="
extract "/vendor/lib64/libkeymaster4.so" "$OUTDIR/lib64/libkeymaster4.so"
extract "/vendor/lib64/libkeymaster_messages.so" "$OUTDIR/lib64/libkeymaster_messages.so"
extract "/vendor/lib64/libpuresoftkeymasterdevice.so" "$OUTDIR/lib64/libpuresoftkeymasterdevice.so"
extract "/vendor/lib64/libsoftkeymasterdevice.so" "$OUTDIR/lib64/libsoftkeymasterdevice.so"
extract "/vendor/lib64/hw/android.hardware.keymaster@4.0-impl.so" "$OUTDIR/lib64/hw/android.hardware.keymaster@4.0-impl.so"

echo ""
echo "=== Gatekeeper ==="
extract "/vendor/lib64/libgatekeeper.so" "$OUTDIR/lib64/libgatekeeper.so"
extract "/vendor/lib64/hw/android.hardware.gatekeeper@1.0-impl.so" "$OUTDIR/lib64/hw/android.hardware.gatekeeper@1.0-impl.so"

echo ""
echo "=== Boot Control (A/B) ==="
extract "/vendor/lib64/hw/android.hardware.boot@1.1-impl.so" "$OUTDIR/lib64/hw/android.hardware.boot@1.1-impl.so"

echo ""
echo "=== Health HAL ==="
extract "/vendor/lib64/hw/android.hardware.health@2.0-impl.so" "$OUTDIR/lib64/hw/android.hardware.health@2.0-impl.so"

echo ""
echo -e "${GREEN}Done! Blobs extracted to $OUTDIR${NC}"
