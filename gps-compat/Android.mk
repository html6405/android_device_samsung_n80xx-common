# Copyright (C) 2026 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := n80xx_glgps_compat
LOCAL_MODULE_STEM := glgps
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_VENDOR_MODULE := true
LOCAL_MODULE_TARGET_ARCH := arm
LOCAL_CHECK_ELF_FILES := false
LOCAL_STRIP_MODULE := false

_n80xx_glgps_input := vendor/samsung/n80xx/system/bin/glgps
_n80xx_patchelf := prebuilts/extract-tools/linux-x86/bin/patchelf-0_18
_n80xx_glgps_output := $(call intermediates-dir-for,EXECUTABLES,$(LOCAL_MODULE))/fixed/glgps
$(_n80xx_glgps_output): PRIVATE_PATCHELF := $(_n80xx_patchelf)
$(_n80xx_glgps_output): $(_n80xx_glgps_input) $(_n80xx_patchelf)
	@mkdir -p $(dir $@)
	cp $< $@
	$(PRIVATE_PATCHELF) --remove-needed libicuuc.so $@
	$(PRIVATE_PATCHELF) --remove-needed libgui.so $@

# The init service already preloads libgps_symbols.so for the old SSL methods.
LOCAL_PREBUILT_MODULE_FILE := $(_n80xx_glgps_output)
include $(BUILD_PREBUILT)
