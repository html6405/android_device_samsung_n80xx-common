# Copyright (C) 2026 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

_n80xx_vendor_compat_local_path := $(LOCAL_PATH)
LOCAL_PATH := vendor/samsung/n80xx
include vendor/samsung/n80xx/n80xx-vendor.mk

# Replace Broadcom GPS on the N8000 and Wi-Fi variants.
# Only the N8000 installs a generated RIL; Wi-Fi variants omit the modem blob.
ifneq ($(TARGET_PRODUCT),lineage_n8020)
PRODUCT_COPY_FILES := $(filter-out %:vendor/bin/glgps %:vendor/lib/libsec-ril.so,$(PRODUCT_COPY_FILES))
endif
LOCAL_PATH := $(_n80xx_vendor_compat_local_path)
_n80xx_vendor_compat_local_path :=
