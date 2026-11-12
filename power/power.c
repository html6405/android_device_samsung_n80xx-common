/*
 * Copyright (C) 2026 The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */
#define LOG_TAG "N80xxPower"
#include <errno.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>

#include <hardware/hardware.h>
#include <hardware/power.h>
#include <log/log.h>

/* Android 14's HIDL wrapper forwards setFeature to this legacy module.
 * DT2W policy (battery timeout and external power) belongs to the driver. */
static void set_double_tap_wake(int enabled)
{
    const char *path = "/sys/class/sec/tsp/dt2w_enable";
    const char value = enabled ? '1' : '0';
    int fd;
    ssize_t result;

    do {
        fd = open(path, O_WRONLY | O_CLOEXEC);
    } while (fd < 0 && errno == EINTR);
    if (fd < 0) {
        ALOGE("Cannot open %s: %s", path, strerror(errno));
        return;
    }
    do {
        result = write(fd, &value, sizeof(value));
    } while (result < 0 && errno == EINTR);
    if (result != (ssize_t)sizeof(value)) {
        ALOGE("Cannot set DT2W to %d: %s", enabled,
              result < 0 ? strerror(errno) : "short write");
    }
    close(fd);
}

static void power_init(struct power_module *module __attribute__((unused)))
{
    set_double_tap_wake(0);
}

static void power_set_feature(struct power_module *module __attribute__((unused)),
                              feature_t feature, int enabled)
{
    if (feature == POWER_FEATURE_DOUBLE_TAP_TO_WAKE)
        set_double_tap_wake(enabled != 0);
}

static struct hw_module_methods_t power_module_methods = {
    .open = NULL,
};

struct power_module HAL_MODULE_INFO_SYM = {
    .common = {
        .tag = HARDWARE_MODULE_TAG,
        .module_api_version = POWER_MODULE_API_VERSION_0_2,
        .hal_api_version = HARDWARE_HAL_API_VERSION,
        .id = POWER_HARDWARE_MODULE_ID,
        .name = "N80xx double-tap wake Power HAL",
        .author = "The LineageOS Project",
        .methods = &power_module_methods,
    },
    .init = power_init,
    .setFeature = power_set_feature,
};
