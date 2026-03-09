#!/bin/bash
#
# Quick build script for TWRP recovery
# Device: Infinix X695C
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Device info
DEVICE="x695c"
VENDOR="infinix"
TWRP_BRANCH="${TWRP_BRANCH:-twrp-11}"

echo -e "${GREEN}====================================${NC}"
echo -e "${GREEN}  TWRP Build Script for X695C${NC}"
echo -e "${GREEN}====================================${NC}"
echo ""

# Check if already in TWRP source
if [ ! -d "build" ]; then
    echo -e "${RED}Error: Not in TWRP source directory${NC}"
    echo "Please run this script from TWRP source root"
    echo ""
    echo "Setup TWRP source first:"
    echo "  repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b $TWRP_BRANCH"
    echo "  repo sync -j\$(nproc)"
    exit 1
fi

# Check device tree
if [ ! -d "device/$VENDOR/$DEVICE" ]; then
    echo -e "${YELLOW}Device tree not found. Cloning...${NC}"
    git clone https://github.com/hoshiyomiX/android_device_infinix_x695c.git device/$VENDOR/$DEVICE
fi

echo -e "${YELLOW}Starting build...${NC}"
echo "Device: $DEVICE"
echo "Vendor: $VENDOR"
echo "Branch: $TWRP_BRANCH"
echo ""

# Build
source build/envsetup.sh
lunch omni_${DEVICE}-eng
mka bootimage -j$(nproc)

# Check build result
if [ -f "out/target/product/$DEVICE/boot.img" ]; then
    echo ""
    echo -e "${GREEN}Build successful!${NC}"
    echo ""
    echo "Output: out/target/product/$DEVICE/boot.img"
    ls -lh out/target/product/$DEVICE/boot.img
    echo ""
    echo "Flash commands:"
    echo "  fastboot flash boot_a boot.img"
    echo "  fastboot flash boot_b boot.img"
    echo "  fastboot reboot recovery"
else
    echo ""
    echo -e "${RED}Build failed!${NC}"
    exit 1
fi
