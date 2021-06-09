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

LOCAL_PATH := device/samsung/n80xx-common

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Screen density
PRODUCT_AAPT_CONFIG := xlarge mdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

# Init files
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/rootdir/fstab.n80xx:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.smdk4x12 \
	$(LOCAL_PATH)/rootdir/fstab.n80xx:$(TARGET_COPY_OUT_RAMDISK)/fstab.smdk4x12 \
    $(LOCAL_PATH)/rootdir/ueventd.smdk4x12.rc:root/ueventd.smdk4x12.rc \
    $(LOCAL_PATH)/rootdir/ueventd.smdk4x12.rc:recovery/root/ueventd.smdk4x12.rc

# Audio
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/configs/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/tiny_hw.xml:vendor/etc/sound/n80xx


# prebuild apps

PRODUCT_PACKAGES += \
	OpenCamera \
	Via

# sec_keyboard
PRODUCT_PACKAGES += \
	sec_keyboard \
	libkeyutils

# Proprietary blobs dependency on libstlport
PRODUCT_PACKAGES +=  libstlport

# Sensors
PRODUCT_PACKAGES += \
    sensors.smdk4x12 \
    lightsensor.smdk4x12

# Power
PRODUCT_PACKAGES += \
    power.smdk4x12

ifneq ($(TARGET_PRODUCT),lineage_n8020)
# Gps
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/gps.xml:vendor/etc/gps.xml

PRODUCT_PACKAGES += \
	gps.smdk4x12 \
	libgps_symbols
endif


# Product specific Packages
PRODUCT_PACKAGES += \
    libsecril-client \
    libsecril-client-sap \
    SamsungServiceMode \
    tinyplay

ifneq ($(TARGET_PRODUCT),lineage_n8010)
# RIL
PRODUCT_PACKAGES += \
	libsecril-shim
endif

# Camera
PRODUCT_PACKAGES += \
    camera.smdk4x12

# ConsumerIR
PRODUCT_PACKAGES += \
    consumerir.exynos4 \
    android.hardware.ir@1.0-impl \
    android.hardware.ir@1.0-service.samsung

PRODUCT_COPY_FILES += \
   	frameworks/native/data/etc/android.hardware.consumerir.xml:system/etc/permissions/android.hardware.consumerir.xml

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

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml

# UMS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/ums_init.sh:system/bin/ums_init.sh

# Set product characteristic to tablet, needed for some ui elements
PRODUCT_CHARACTERISTICS := tablet

# Vendor security patch level
PRODUCT_PROPERTY_OVERRIDES += \
    ro.lineage.build.vendor_security_patch=2015-11-05

$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

$(call inherit-product-if-exists, vendor/samsung/n80xx-treble/n80xx-vendor.mk)
