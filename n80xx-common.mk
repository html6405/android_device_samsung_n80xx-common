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

$(call inherit-product, device/samsung/smdk4412-common/common.mk)

LOCAL_PATH := device/samsung/n80xx-common

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay-common

# Screen density
PRODUCT_AAPT_CONFIG := xlarge mdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/ueventd.smdk4x12.rc:root/ueventd.smdk4x12.rc \
    $(LOCAL_PATH)/rootdir/ueventd.smdk4x12.rc:recovery/root/ueventd.smdk4x12.rc \
    $(LOCAL_PATH)/rootdir/fstab.n80xx:root/fstab.smdk4x12

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio_policy.conf:system/etc/audio_policy.conf

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/tiny_hw.xml:system/etc/sound/n80xx

# prebuild apps

PRODUCT_PACKAGES += \
	MagiskManager \
	OpenCamera

# Camera
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml

PRODUCT_PACKAGES += \
    camera.smdk4x12

# ConsumerIR
PRODUCT_PACKAGES += \
    consumerir.exynos4

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:system/etc/permissions/android.hardware.consumerir.xml

# Product specific Packages
PRODUCT_PACKAGES += \
    tinyplay \
    libsecril-client

# Sensors
PRODUCT_PACKAGES += \
    sensors.smdk4x12

# Power
PRODUCT_PACKAGES += \
    power.smdk4x12

ifeq ($(TARGET_PRODUCT),lineage_n8000)
# Gps
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/gps.xml:system/etc/gps.xml \
    $(LOCAL_PATH)/gps_daemon.sh:system/vendor/bin/gps_daemon.sh

PRODUCT_PACKAGES += \
	gps.smdk4x12
endif

ifeq ($(TARGET_PRODUCT),lineage_n8000_deodexed)
# Gps
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/gps.xml:system/etc/gps.xml \
    $(LOCAL_PATH)/gps_daemon.sh:system/vendor/bin/gps_daemon.sh

PRODUCT_PACKAGES += \
	gps.smdk4x12
endif

ifeq ($(TARGET_PRODUCT),lineage_n8010)
# Gps
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/gps.xml:system/etc/gps.xml \
    $(LOCAL_PATH)/gps_daemon.sh:system/vendor/bin/gps_daemon.sh

PRODUCT_PACKAGES += \
	gps.smdk4x12
endif

# sec_keyboard
PRODUCT_PACKAGES += \
	sec_keyboard \
	libkeyutils

# shim libs for gpsd
    PRODUCT_PACKAGES += \
        libn80xx

# RIL
PRODUCT_PACKAGES += \
	libsamsung_symbols \
	libsecril-shim

# f2fs
PRODUCT_PACKAGES += \
	fibmap.f2fs \
	fsck.f2fs \
	mkfs.f2fs

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.ril_class=SamsungExynos4RIL \
    ro.telephony.call_ring.multiple=false \
    ro.telephony.call_ring.delay=3000

# ART
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat-flags=--no-watch-dog \
    dalvik.vm.dex2oat-swap=false

# I/O Scheduler
PRODUCT_PROPERTY_OVERRIDES += \
    sys.io.scheduler=cfq

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.software.connectionservice.xml:system/etc/permissions/android.software.connectionservice.xml

# Set product characteristic to tablet, needed for some ui elements
PRODUCT_CHARACTERISTICS := tablet

$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

$(call inherit-product-if-exists, vendor/samsung/n80xx/n80xx-vendor.mk)
