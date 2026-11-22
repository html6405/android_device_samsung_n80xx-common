# Samsung Exynos4 N80xx shared device configuration

Shared device configuration and compatibility support for the Samsung Galaxy Note 10.1 family, targeting **LineageOS 21 / Android 14** in this branch.

## LineageOS 21 releases

Use model-specific repositories for ROMs, checksums, installation requirements and tested status. This shared repository provides the overview; it does not turn one model's build into a family-wide ROM.

| Model | Device / release archive | Current LOS21 validation |
| --- | --- | --- |
| GT-N8000 | [Device notes](https://github.com/html6405/android_device_samsung_n8000/tree/lineage-21.0-2026) · [2026-11-22 experimental release](https://github.com/html6405/android_device_samsung_n8000/releases/tag/lineage-21.0-20261122) | 2026-11-22 experimental release, userdebug/Enforcing. Bluetooth two-way calls/media and Phone graphics pass observed tests; pen/mic checks completed. 26m59s cumulative suspend without a new failure. HEVC hidden; Prime previews and long-standby SurfaceFlinger issue remain open. |
| GT-N8010 | [Device tree](https://github.com/html6405/android_device_samsung_n8010/tree/lineage-21.0) · [Releases](https://github.com/html6405/android_device_samsung_n8010/releases) | Host build completed on 2026-11-22 with Wi-Fi kernel/configuration and ZIP checks passed; no hardware acceptance for this cycle. Verify Wi-Fi-only kernel setup and actual partition layout. |
| GT-N8013 | [Repository](https://github.com/html6405/android_device_samsung_n8013) · [Releases](https://github.com/html6405/android_device_samsung_n8013/releases) | No dedicated LOS21 branch is published yet; model-specific source and hardware validation remain pending. |
| GT-N8020 | [Device tree](https://github.com/html6405/android_device_samsung_n8020/tree/lineage-21.0) · [Releases](https://github.com/html6405/android_device_samsung_n8020/releases) | Not validated in this cycle; separate LTE/modem and audio/device validation required. |

The release archives may contain other Android versions. Select a tag explicitly matching model and LineageOS21. The inspected LOS21 test unit is a 16 GB N8000 with 2 GiB SYSTEM, 500 MiB HIDDEN/VENDOR and 152 MiB CACHE, plus 8 MiB BOOT/recovery. This is actual LOS21 test geometry, not a copied LOS23 requirement or a minimum-size guarantee for every model. Recovery bytes stayed unchanged. ROM installation does not repartition automatically, and N8010/other layouts need their own verification.

N8000 release ZIP: [`lineage-21.0-20261122-HTML6405-n8000.zip`](https://github.com/html6405/android_device_samsung_n8000/releases/download/lineage-21.0-20261122/lineage-21.0-20261122-HTML6405-n8000.zip), **618126733 bytes**; [SHA-256 sidecar](https://github.com/html6405/android_device_samsung_n8000/releases/download/lineage-21.0-20261122/lineage-21.0-20261122-HTML6405-n8000.zip.sha256). SHA-256: `95402542b87045b5be9d3027d1180406e3d25e5745f02191a4f72816ecdb1df7`. The release includes manifest/revision/source-supplement assets; its Git tag is a public device-tree baseline, not the complete compiled Android source tree.

## Maintained sources

The shared trees and published N8000 platform/kernel sources use **`lineage-21.0-2026`**. Use the [pinned N8000 source manifest](https://github.com/html6405/android_device_samsung_n8000/blob/lineage-21.0-2026/release-source-manifest.xml) for exact revisions. N8010, N8013 and N8020 have separate source-readiness and hardware-validation work; this branch does not claim a tested release for them.

## Shared compatibility areas

This tree supplies common tablet services and configuration, DT2W support, the preserved PID-based keyboard workaround, legacy GPS/audio integration, dock routing, partition initialization and scoped SELinux labels/rules. Per-model radio capabilities remain separate: N8000 cellular behavior is not applicable evidence for Wi-Fi-only N8010. Camera3 migration is deferred; LOS21 currently retains its legacy camera path.

Current N8000 evidence includes two-way Bluetooth cellular calls, media/speaker playback, call-volume fixes, late single-SIM data subscription handling and a user-confirmed mobile-data indication. The Phone UI EGL/allocator crash was repaired in the tested path; framework suspend wake-lock acquisition also passed. Pen and microphone/privacy checks were completed by the user. A no-USB interval measured 26m59s cumulative real suspend over nine cycles without a new crash/denial after baseline. This short regression does not resolve the earlier long-standby SurfaceFlinger crash. Prime green previews remain open, HEVC stays hidden, and Camera3/Aperture/GPS ports are deferred. RIL private-database probes remain intentionally denied with fallback. SELinux is Enforcing but the legacy ignore-neverallows setting and existing exceptions remain; the isolated full check still reports 344 baseline violations. See the model changelog for exact evidence and limits.

## Release coordination

Review local LOS23 commits and working-tree changes before issue fixes and release builds, adapting version-specific dependencies rather than copying them blindly. Keep original authorship and required workarounds. The current N8000 publication is explicitly experimental with disclosed remaining crashes and visual issues; a release entry must not imply a stable build or all functions passing.

For each accepted model release, maintain a distinct `lineage-21.0-YYYYMMDD` tag in its own repository, exact ROM/checksum links, source revision/manifest/supplement provenance and model-specific test limits. Update the device README/changelog, then this overview. The final N8000 metadata now has timestamp `1795334343` and incremental `eng.html64.20261122.085904`; older stale-metadata test archives remain distinct. Security-patch level is still **2024-08-05**. Updater release/changelog links and automatic feed delivery require separate verification.

The central Exynos4 work order is N8000, then N8010. Shared source changes require an explicit per-model test record; source inheritance alone is not proof that a feature works on every tablet.
