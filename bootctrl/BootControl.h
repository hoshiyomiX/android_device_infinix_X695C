#ifndef ANDROID_HARDWARE_BOOT_V1_1_BOOTCONTROL_H
#define ANDROID_HARDWARE_BOOT_V1_1_BOOTCONTROL_H

#include <android/hardware/boot/1.1/IBootControl.h>
#include <hidl/Status.h>

namespace android::hardware::boot::V1_1::implementation {

using ::android::hardware::Return;
using ::android::hardware::Void;

struct BootControl : public IBootControl {
    BootControl();
    Return<uint32_t> getNumberSlots() override;
    Return<uint32_t> getCurrentSlot() override;
    Return<void> markBootSuccessful(markBootSuccessful_cb _hidl_cb) override;
    Return<void> setActiveBootSlot(uint32_t slot, setActiveBootSlot_cb _hidl_cb) override;
    Return<void> setSlotAsUnbootable(uint32_t slot, setSlotAsUnbootable_cb _hidl_cb) override;
    Return<::android::hardware::boot::V1_0::BoolResult> isSlotBootable(uint32_t slot) override;
    Return<void> getSuffix(uint32_t slot, getSuffix_cb _hidl_cb) override;
    Return<::android::hardware::boot::V1_0::BoolResult> isSlotMarkedSuccessful(uint32_t slot) override;
    Return<bool> setSnapshotMergeStatus(MergeStatus status) override;
    Return<MergeStatus> getSnapshotMergeStatus() override;
};

}  // namespace android::hardware::boot::V1_1::implementation

#endif
