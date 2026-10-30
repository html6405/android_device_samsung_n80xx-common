# Copyright (C) 2026 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := n80xx_libsec_ril_compat
LOCAL_MODULE_STEM := libsec-ril
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_VENDOR_MODULE := true
LOCAL_MODULE_TARGET_ARCH := arm
LOCAL_CHECK_ELF_FILES := false
LOCAL_STRIP_MODULE := false
LOCAL_SHARED_LIBRARIES := smdk4412_libcutils_compat

ifeq ($(TARGET_PRODUCT),lineage_n8020)
# Keep the Qualcomm modem blob and its existing libshim_ril preload.
_n80xx_ril_input := vendor/samsung/n8020/proprietary/lib/libsec-ril.so
else
_n80xx_ril_input := vendor/samsung/n80xx/system/lib/libsec-ril.so
endif
_n80xx_ril_patchelf := prebuilts/extract-tools/linux-x86/bin/patchelf-0_18
_n80xx_ril_output := $(call intermediates-dir-for,SHARED_LIBRARIES,$(LOCAL_MODULE))/fixed/libsec-ril.so
$(_n80xx_ril_output): PRIVATE_PATCHELF := $(_n80xx_ril_patchelf)
$(_n80xx_ril_output): $(_n80xx_ril_input) $(_n80xx_ril_patchelf)
	@mkdir -p $(dir $@)
	cp $< $@
	$(PRIVATE_PATCHELF) --replace-needed libcutils-v29.so smdk4412_libcutils_compat.so $@

LOCAL_PREBUILT_MODULE_FILE := $(_n80xx_ril_output)
include $(BUILD_PREBUILT)
