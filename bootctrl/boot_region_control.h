#ifndef BOOT_REGION_CONTROL_H
#define BOOT_REGION_CONTROL_H

#ifdef __cplusplus
extern "C" {
#endif

int boot_control_init(void);
int get_active_slot(void);
int set_active_slot(int slot);
int mark_boot_successful(void);
int set_slot_as_unbootable(int slot);
int is_slot_bootable(int slot);
int is_slot_marked_successful(int slot);

#ifdef __cplusplus
}
#endif

#endif
