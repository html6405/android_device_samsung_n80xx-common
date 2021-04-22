#include <stdlib.h>

#include <android-base/file.h>
#include <android-base/logging.h>
#include <android-base/properties.h>
#include <android-base/strings.h>

#include "property_service.h"
#include "vendor_init.h"

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

using android::base::GetProperty;
using android::base::ReadFileToString;
using android::base::Trim;
using android::init::property_set;

#define SERIAL_NUMBER_FILE "/efs/FactoryApp/serial_no"

void property_override(char const prop[], char const value[])
{
    prop_info *pi;

    pi = (prop_info*) __system_property_find(prop);
    if (pi)
        __system_property_update(pi, value, strlen(value));
    else
        __system_property_add(prop, strlen(prop), value, strlen(value));
}

void property_override_dual(char const system_prop[], char const vendor_prop[], char const value[])
{
    property_override(system_prop, value);
    property_override(vendor_prop, value);
}

void vendor_load_properties()
{
    const std::string bootloader = GetProperty("ro.bootloader", "");
    const std::string platform = GetProperty("ro.board.platform", "");

    char const *serial_number_file = SERIAL_NUMBER_FILE;
    std::string serial_number;

    if (platform != ANDROID_TARGET)
        return;

    if (ReadFileToString(serial_number_file, &serial_number)) {
        serial_number = Trim(serial_number);
        property_override("ro.serialno", serial_number.c_str());
    }

    if (bootloader.find("N8000") != std::string::npos) {
        property_override_dual("ro.product.model", "ro.vendor.product.model", "GT-N8000");
        property_override_dual("ro.product.device", "ro.vendor.product.device", "p4noterf");
        property_override_dual("ro.product.device", "ro.vendor.product.name", "p4noterfxx");
        property_override_dual("ro.build.description", "ro.vendor.build.description", "p4noterfxx-user 4.4.2 KOT49H N8000XXUDPB1 release-keys");
        property_override_dual("ro.build.fingerprint", "ro.vendor.build.fingerprint", "samsung/p4noterfxx/p4noterf:4.4.2/KOT49H/N8000XXUDPB1:user/release-keys");
        property_override("ro.build.product", "n8000");
    } else if (bootloader.find("N8005") != std::string::npos) {
        property_override_dual("ro.product.model", "ro.vendor.product.model", "GT-N8000");
        property_override_dual("ro.product.device", "ro.vendor.product.device", "p4noterf");
        property_override_dual("ro.product.device", "ro.vendor.product.name", "p4noterfxx");
        property_override_dual("ro.build.description", "ro.vendor.build.description", "p4noterfxx-user 4.4.2 KOT49H N8000XXUDPB1 release-keys");
        property_override_dual("ro.build.fingerprint", "ro.vendor.build.fingerprint", "samsung/p4noterfxx/p4noterf:4.4.2/KOT49H/N8000XXUDPB1:user/release-keys");
        property_override("ro.build.product", "n8000");
     } else if (bootloader.find("N8010") != std::string::npos) {
        property_override_dual("ro.product.model", "ro.vendor.product.model", "GT-N8010");
        property_override_dual("ro.product.device", "ro.vendor.product.device", "p4notewifi");
        property_override_dual("ro.product.name", "ro.vendor.product.name", "p4notewifiue");
        property_override_dual("ro.build.description", "ro.vendor.build.description", "p4notewifixx-user 4.4.2 KOT49H N8010XXUDNE4 release-keys");
        property_override_dual("ro.build.fingerprint", "ro.vendor.build.fingerprint", "samsung/p4notewifixx/p4notewifiww:4.4.2/KOT49H/N8010XXUDNE4:user/release-keys");
        property_override("ro.build.product", "n8010");
    } else if (bootloader.find("N8013") != std::string::npos) {
        property_override_dual("ro.product.model", "ro.vendor.product.model", "GT-N8013");
        property_override_dual("ro.product.device", "ro.vendor.product.device", "p4notewifi");
        property_override_dual("ro.product.name", "ro.vendor.product.name", "p4notewifiue");
        property_override_dual("ro.build.description", "ro.vendor.build.description", "p4notewifiue-user 4.1.2 JZO54K N8013UEUCOI1 release-keys");
        property_override_dual("ro.build.fingerprint", "ro.vendor.build.fingerprint", "samsung/p4notewifiue/p4notewifi:4.1.2/JZO54K/N8013UEUCOI1:user/release-keys");
        property_override("ro.build.product", "n8013");
    } else if (bootloader.find("N8020") != std::string::npos) {
        property_override_dual("ro.product.model", "ro.vendor.product.model", "GT-N8020");
        property_override_dual("ro.product.device", "ro.vendor.product.device", "p4notelte");
        property_override_dual("ro.product.name", "ro.vendor.product.name", "p4noteltexx");
        property_override_dual("ro.build.description", "ro.vendor.build.description", "p4noteltexx-user 4.4.2 KOT49H N8020XXSDQA4 release-keys");
        property_override_dual("ro.build.fingerprint", "ro.vendor.build.fingerprint", "samsung/p4noteltexx/p4notelte:4.4.2/KOT49H/N8020XXSDQA4:user/release-keys");
        property_override("ro.build.product", "n8020");
    }
    else {
        /* Fall back to GT-N8010 (Wifi version) */
        property_override_dual("ro.product.model", "ro.vendor.product.model", "GT-N8010");
        property_override_dual("ro.product.device", "ro.vendor.product.device", "p4notewifi");
        property_override_dual("ro.product.name", "ro.vendor.product.name", "p4notewifiue");
        property_override_dual("ro.build.description", "ro.vendor.build.description", "p4notewifixx-user 4.4.2 KOT49H N8010XXUDNE4 release-keys");
        property_override_dual("ro.build.fingerprint", "ro.vendor.build.fingerprint", "samsung/p4notewifixx/p4notewifiww:4.4.2/KOT49H/N8010XXUDNE4:user/release-keys");
        property_override("ro.build.product", "n8010");
    }

    const std::string device = GetProperty("ro.product.device", "");
    LOG(INFO) << "Found bootloader " << bootloader << ". " << "Setting build properties for " << device << ".\n";
}
