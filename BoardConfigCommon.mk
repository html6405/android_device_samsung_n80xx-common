#
# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include device/samsung/smdk4412-common/BoardCommonConfig.mk

DEVICE_PATH := device/samsung/n80xx-common

WITHOUT_CAMERA2 := true
WITHOUT_GCAM := true

# Wifi
WIFI_DRIVER_MODULE_PATH :=

# Bionic
MALLOC_SVELTE := true
TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS := true
LIBART_IMG_BASE := 0x30000000

TARGET_LD_SHIM_LIBS := \
    /vendor/bin/glgps|libgps_symbols.so

# Graphics
TARGET_REQUIRES_SYNCHRONOUS_SETSURFACE := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
BOARD_EGL_NEEDS_HANDLE_VALUE := true
TARGET_ENABLE_MEDIADRM_64 := true

# HIDL
DEVICE_MATRIX_FILE := $(DEVICE_PATH)/compatibility_matrix.xml

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/samsung/n80xx-common/bluetooth

# Kernel
TARGET_KERNEL_SOURCE := kernel/samsung/smdk4412
TARGET_KERNEL_CONFIG := lineageos_n8013_defconfig

TARGET_SPECIFIC_HEADER_PATH += device/samsung/n80xx-common/include

# Filesystem
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1444888576
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12620578800
BOARD_CACHEIMAGE_PARTITION_SIZE := 825638912
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 2048
TARGET_RECOVERY_DEVICE_DIRS += device/samsung/n80xx-common


# Recovery
TARGET_RECOVERY_FSTAB := device/samsung/n80xx-common/rootdir/fstab.n80xx
TARGET_RECOVERY_DENSITY := mdpi
TARGET_USERIMAGES_USE_F2FS := true
RECOVERY_FSTAB_VERSION := 2

# PowerHAL
TARGET_POWERHAL_VARIANT := pegasusq

# Init
ifneq ($(WITH_TWRP), true)
TARGET_INIT_VENDOR_LIB := libinit_n80xx
endif