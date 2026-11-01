# SPDX-License-Identifier: Apache-2.0

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_ARCH),arm)
include $(CLEAR_VARS)
LOCAL_MODULE := n80xx_webview_gles2
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_PRODUCT_MODULE := true
LOCAL_CERTIFICATE := $(DEFAULT_SYSTEM_DEV_CERTIFICATE)
LOCAL_OVERRIDES_PACKAGES := webview
LOCAL_REQUIRED_MODULES := libwebviewchromium_loader libwebviewchromium_plat_support
LOCAL_OPTIONAL_USES_LIBRARIES := android.test.base androidx.window.extensions com.android.extensions.xr

_n80xx_webview_input := external/chromium-webview/prebuilt/arm/webview.apk
_n80xx_webview_patcher := $(HOST_OUT_EXECUTABLES)/n80xx_patch_webview_gles2
_n80xx_webview_output := $(call intermediates-dir-for,APPS,$(LOCAL_MODULE),,COMMON)/gles2/webview.apk
$(_n80xx_webview_output): PRIVATE_WEBVIEW_PATCHER := $(_n80xx_webview_patcher)
$(_n80xx_webview_output): $(_n80xx_webview_input) $(_n80xx_webview_patcher) $(LOCAL_PATH)/patch_webview_gles2.py
	@mkdir -p $(dir $@)
	$(PRIVATE_WEBVIEW_PATCHER) $< $@

# BUILD_PREBUILT signs the generated APK with the same certificate as webview.
LOCAL_PREBUILT_MODULE_FILE := $(_n80xx_webview_output)
include $(BUILD_PREBUILT)
endif
