#define LOG_TAG "bootctrl"

#include <log/log.h>
#include <cstring>
#include "boot_region_control.h"

static int current_slot = 0;
static bool initialized = false;

int boot_control_init(void) {
    if (initialized) return 0;
    
    char slot[2] = {0};
    FILE* fp = fopen("/proc/cmdline", "r");
    if (fp) {
        char cmdline[1024];
        if (fgets(cmdline, sizeof(cmdline), fp)) {
            if (strstr(cmdline, "androidboot.slot_suffix=_b") ||
                strstr(cmdline, "androidboot.slot=b")) {
                current_slot = 1;
            }
        }
        fclose(fp);
    }
    
    initialized = true;
    ALOGI("Boot control initialized, slot=%c", current_slot == 0 ? 'A' : 'B');
    return 0;
}

int get_active_slot(void) {
    if (!initialized) boot_control_init();
    return current_slot;
}

int set_active_slot(int slot) {
    if (slot < 0 || slot > 1) return -1;
    current_slot = slot;
    ALOGI("Set active slot to %c", slot == 0 ? 'A' : 'B');
    return 0;
}

int mark_boot_successful(void) {
    ALOGI("Marked boot successful");
    return 0;
}

int set_slot_as_unbootable(int slot) {
    if (slot < 0 || slot > 1) return -1;
    ALOGI("Slot %c marked as unbootable", slot == 0 ? 'A' : 'B');
    return 0;
}

int is_slot_bootable(int slot) {
    return 1;  // Always bootable for now
}

int is_slot_marked_successful(int slot) {
    return 1;  // Always successful for now
}
