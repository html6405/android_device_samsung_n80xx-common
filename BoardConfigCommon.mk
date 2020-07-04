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

# This variable is set first, so it can be overridden
# by BoardConfigVendor.mk
-include device/samsung/smdk4412-common/BoardCommonConfig.mk

# Kernel
TARGET_KERNEL_SOURCE := kernel/samsung/n80xx
TARGET_KERNEL_CONFIG := lineageos_$(TARGET_DEVICE)_defconfig

# Wifi
WIFI_DRIVER_MODULE_PATH :=

ifeq ($(TARGET_PRODUCT),slim_n8000)
# Headers
TARGET_SPECIFIC_HEADER_PATH += device/samsung/n80xx-common/include
endif

ifeq ($(TARGET_PRODUCT),slim_n8000_deodexed)
# Headers
TARGET_SPECIFIC_HEADER_PATH += device/samsung/n80xx-common/include
endif

ifeq ($(TARGET_PRODUCT),slim_n8010)
# Headers
TARGET_SPECIFIC_HEADER_PATH += device/samsung/n80xx-common/include
endif

#Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/samsung/n80xx-common/bluetooth

# Bionic
MALLOC_SVELTE := true
TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS := true
LIBART_IMG_BASE := 0x30000000

# RIL
BOARD_PROVIDES_LIBRIL := true
BOARD_MODEM_TYPE := xmm6262
BOARD_GLOBAL_CFLAGS += -DDISABLE_ASHMEM_TRACKING
BOARD_RIL_CLASS := ../../../device/samsung/n80xx-common/ril

# Graphics
TARGET_REQUIRES_SYNCHRONOUS_SETSURFACE := true

ifdef EXYNOS4X12_ENHANCEMENTS
BOARD_GLOBAL_CFLAGS += -DDISABLE_HW_ID_MATCH_CHECK
endif

# Camera
BOARD_USES_PROPRIETARY_LIBCAMERA := true
BOARD_USES_PROPRIETARY_LIBFIMC := false
BOARD_CAMERA_HAVE_ISO := true
BOARD_GLOBAL_CFLAGS += -DHAVE_ISO
BOARD_GLOBAL_CFLAGS += -DSAMSUNG_CAMERA_HARDWARE
BOARD_GLOBAL_CFLAGS += -DSAMSUNG_DVFS
BOARD_GLOBAL_CFLAGS += -DCAMERA_WITH_CITYID_PARAM
BOARD_CAMERA_MSG_MGMT := true

#HWC
BOARD_USE_SYSFS_VSYNC_NOTIFICATION := false

# Filesystem
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1444888576
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12620578816
BOARD_CACHEIMAGE_PARTITION_SIZE := 825638912
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_FLASH_BLOCK_SIZE := 2048
TARGET_RECOVERY_DEVICE_DIRS += device/samsung/n80xx-common

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
  WITH_DEXPREOPT := true
endif

# Recovery
TARGET_RECOVERY_FSTAB := device/samsung/n80xx-common/rootdir/fstab.n80xx
TARGET_RECOVERY_DENSITY := mdpi
TARGET_USERIMAGES_USE_F2FS := true
RECOVERY_FSTAB_VERSION := 2

# HDMIE
#BOARD_USES_HDMI := true
#BOARD_HDMI_STD := true
#BOARD_HDMI_DDC_CH := DDC_CH_I2C_5

# PowerHAL
TARGET_POWERHAL_VARIANT := pegasusq

# Selinux
BOARD_SEPOLICY_DIRS += \
    device/samsung/n80xx-common/selinux

# inherit from the proprietary version
-include vendor/samsung/n80xx-common/BoardConfigVendor.mk
