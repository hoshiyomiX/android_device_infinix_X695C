#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <android-base/properties.h>
#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

using android::base::GetProperty;
using std::string;

void property_override(string prop, string value) {
    auto pi = (prop_info *)__system_property_find(prop.c_str());
    if (pi != nullptr)
        __system_property_update(pi, value.c_str(), value.size());
    else
        __system_property_add(prop.c_str(), prop.size(), value.c_str(), value.size());
}

void vendor_load_properties() {
    property_override("ro.product.brand", "Infinix");
    property_override("ro.product.name", "X695C-GL");
    property_override("ro.product.device", "Infinix-X695C");
    property_override("ro.product.model", "Infinix X695C");
    property_override("ro.product.manufacturer", "INFINIX MOBILITY LIMITED");
}
