# N80xx shared changelog

## 2026-11-22 — experimental shared release support

- Share specific ION property labeling, initialization and codec-client reads for
  Enforcing audio/video startup. Device packages require their own tests.
- Retain Samsung AVC crop/flush, PTS guard, software fallback, HEVC-off and legacy
  GLES/EGL/WebView compatibility. HEVC is disabled rather than repaired.
- Preserve original keyboard/init lifecycle; failed hotplug experiments are excluded.
- Use the corrected OTA backup script through the platform OTA packaging flow.
  Two-update/addon preservation is not yet validated.

N8000 and N8010 remain distinct builds with different radio, memory-history and
partition settings. N8010 sleep/wake and bounded media tests do not validate
N8020 or other models. ueventd restart, preview artifacts, dock IME behavior and
incomplete SELinux/security validation remain known limitations. See model
release notes for checksums, installation requirements and runtime evidence.
