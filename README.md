# Samsung Exynos4 N80xx shared device configuration

November 24 VFP kernel previews are available for [GT-N8000](https://github.com/html6405/android_device_samsung_n8000/releases/tag/lineage-23.2-20261124-vfp-preview) and [GT-N8010 / GT-N8013](https://github.com/html6405/android_device_samsung_n8010/releases/tag/lineage-23.2-20261124-vfp-preview). See the release notes for manual installation and test coverage.

Shared device configuration and compatibility support for the Samsung Galaxy Note 10.1 family.

## LineageOS 23.2 releases

ROMs are published in each device repository so downloads, checksums, requirements, and test status stay specific to the model. The shared tree links to each model's release page:

| Model | Release page | LOS 23.2 status |
| --- | --- | --- |
| GT-N8000 | [2026-11-22 experimental release](https://github.com/html6405/android_device_samsung_n8000/releases/tag/lineage-23.2-20261122) | Vanilla Enforcing userdebug; tested on one 32 GB device. Platform HEVC disabled; known ueventd/graphics/dock issues remain. |
| GT-N8010 / GT-N8013 | [2026-11-22 experimental release](https://github.com/html6405/android_device_samsung_n8010/releases/tag/lineage-23.2-20261122) | Enforcing, Wi-Fi-only, corrected OTA wrapper. See device-specific tests and known issues. |
| GT-N8020 | [Downloads](https://github.com/html6405/android_device_samsung_n8020/releases) | No LOS 23.2 ROM release yet; separate modem/device validation is required. |

Both N8000 and the shared N8010/N8013 ROM require a prepared **2 GiB SYSTEM** partition. Their CACHE layouts differ:

| Model | SYSTEM | CACHE |
| --- | ---: | ---: |
| N8000 | 2 GiB | 152 MiB |
| N8010 / N8013 | 2 GiB | 739241984 bytes (about 705 MiB) |

Use the separate [N80xx repartitioning project](https://github.com/html6405/n80xx-repartition/releases)
and read its [model-specific support and installation instructions](https://github.com/html6405/n80xx-repartition#device-support).
The N8010 profile is currently experimental. Only use a matching checked layout;
never copy another model's boundaries. A device already at the required layout
must not be repartitioned again. The repartitioner creates a fresh System and
requires verified backups; ROM updates do not repartition the device.

The 2026-11-21 N8000 release passed final Prime AVC playback and forward/backward seeking. Earlier candidate tests covered Bluetooth call audio through the tested Dots, post-call media audio, camera AVC recording/playback and a bounded unplugged sleep/wake test. These results do not validate the other models. The intermittent partial-image issue after seeking and dock/modem boot reports remain open; refer to the device release notes for exact test limits.

## Shared compatibility areas

This tree contains shared Exynos4-family support for legacy Samsung radio and GPS components, graphics properties, USB configuration, audio docks, WebView GLES2 compatibility, and related device services. Device-specific release notes identify which functions were built and tested for each model.

Contributions should target the `lineage-23.2` branch and retain original commit authorship when porting upstream fixes.

## 2026-11-22 shared release support

N8000 and N8010 packages include the tested specific ION property label, setter
and codec-client reads for Enforcing, shared AVC/PTS changes, HEVC-off policy and
common graphics compatibility. Original dock keyboard/init behavior is retained;
failed dynamic keyboard trials are excluded. Their shared source does not imply
identical hardware acceptance. N8010 disables modem paths and memory-history
diagnostics intentionally. See [shared changelog](CHANGELOG.md) and each device
README for exact artifacts, layouts, optional KernelSU Manager and test limits.

An auto-restarted ueventd ReadUevent+156 crash remains unresolved on N8010 and was
previously observed on N8000. No crash-free or full Enforcing security claim is
made. Corrected OTA backup scripts are packaged; successive OTA/addon survival
is still pending. The experimental userdebug KernelSU profile is not hardened.

## Optional microG

The [optional microG Recovery installer](https://github.com/html6405/exynos4-microg-installer/releases/tag/v0.1.0-rc1) is a separate download for compatible
HTML6405 LineageOS 23.2 Vanilla builds. Its release notes list supported
Recovery identities and the GT-N8010 installation and OTA test coverage.

**Recommended for daily use on GT-N8000: [microG with Companion](https://github.com/html6405/exynos4-microg-installer/releases/tag/v0.1.0-rc1).** The tester reported a substantially quicker return to the lock screen after switching to Companion. App launch timings varied with uptime, account state and background load. The [microG with the original Play Store](https://github.com/html6405/exynos4-microg-installer/releases/tag/v0.1.0-phonesky-r7) preview installed and launched a test app under Enforcing on GT-N8000 with the r7 system configuration. Full r7 ZIP, Store self-update and Vanilla OTA validation are pending. The lighter Companion variant is also the recommendation for GT-N8010 / GT-N8013.
