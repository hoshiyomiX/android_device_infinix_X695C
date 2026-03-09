#define LOG_TAG "bootctrl"

#include <log/log.h>
#include <android/hardware/boot/1.1/IBootControl.h>
#include <hidl/HidlSupport.h>
#include <hidl/HidlTransportSupport.h>

#include "BootControl.h"
#include "boot_region_control.h"

namespace android {
namespace hardware {
namespace boot {
namespace V1_1 {
namespace implementation {

using ::android::hardware::boot::V1_0::BoolResult;
using ::android::hardware::boot::V1_0::CommandResult;
using ::android::hardware::Return;
using ::android::hardware::Void;

BootControl::BootControl() {
    boot_control_init();
}

Return<uint32_t> BootControl::getNumberSlots() {
    return 2;
}

Return<uint32_t> BootControl::getCurrentSlot() {
    return static_cast<uint32_t>(get_active_slot());
}

Return<void> BootControl::markBootSuccessful(markBootSuccessful_cb _hidl_cb) {
    CommandResult result;
    result.success = (mark_boot_successful() == 0);
    _hidl_cb(result);
    return Void();
}

Return<void> BootControl::setActiveBootSlot(uint32_t slot, setActiveBootSlot_cb _hidl_cb) {
    CommandResult result;
    result.success = (set_active_slot(static_cast<int>(slot)) == 0);
    _hidl_cb(result);
    return Void();
}

Return<void> BootControl::setSlotAsUnbootable(uint32_t slot, setSlotAsUnbootable_cb _hidl_cb) {
    CommandResult result;
    result.success = (set_slot_as_unbootable(static_cast<int>(slot)) == 0);
    _hidl_cb(result);
    return Void();
}

Return<BoolResult> BootControl::isSlotBootable(uint32_t slot) {
    return is_slot_bootable(static_cast<int>(slot)) ? BoolResult::TRUE : BoolResult::FALSE;
}

Return<void> BootControl::getSuffix(uint32_t slot, getSuffix_cb _hidl_cb) {
    _hidl_cb(hidl_string(slot == 0 ? "_a" : "_b"));
    return Void();
}

Return<BoolResult> BootControl::isSlotMarkedSuccessful(uint32_t slot) {
    return is_slot_marked_successful(static_cast<int>(slot)) ? BoolResult::TRUE : BoolResult::FALSE;
}

Return<bool> BootControl::setSnapshotMergeStatus(MergeStatus status) {
    ALOGI("setSnapshotMergeStatus: %d", static_cast<int>(status));
    return true;
}

Return<MergeStatus> BootControl::getSnapshotMergeStatus() {
    return MergeStatus::NONE;
}

}  // namespace implementation
}  // namespace V1_1
}  // namespace boot
}  // namespace hardware
}  // namespace android
