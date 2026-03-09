#include <iostream>
#include <string>
#include <android-base/properties.h>

int main(int argc, char** argv) {
    std::cout << "MTK PLPath Utils - X695C" << std::endl;
    std::cout << "Current slot: " << android::base::GetProperty("ro.boot.slot_suffix", "_a") << std::endl;
    return 0;
}
