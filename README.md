# Samsung Exynos4 N80xx shared device configuration

Shared device configuration and compatibility support for the Samsung Galaxy Note 10.1 family, targeting **LineageOS 21 / Android 14** in this branch.

## LineageOS 21 releases

Use model-specific repositories for ROMs, checksums, installation requirements and tested status. This shared repository provides the overview; it does not turn one model's build into a family-wide ROM.

| Model | Device / release archive | Current LOS21 validation |
| --- | --- | --- |
| GT-N8000 | [Device notes](https://github.com/html6405/android_device_samsung_n8000/tree/lineage-21.0) · [2026-11-21 experimental release](https://github.com/html6405/android_device_samsung_n8000/releases/tag/lineage-21.0-20261121) | 2026-11-21 experimental release, userdebug/Enforcing. DT2W and bounded AVC checks pass. HEVC deliberately hidden; green Prime previews and SurfaceFlinger standby/resume crash remain open. |
| GT-N8010 | [Device tree](https://github.com/html6405/android_device_samsung_n8010/tree/lineage-21.0) · [Releases](https://github.com/html6405/android_device_samsung_n8010/releases) | Next target. Source readiness reviewed; no build/flash/hardware acceptance for this cycle. Verify Wi-Fi-only kernel setup and actual partition layout. |
| GT-N8013 | [Device tree](https://github.com/html6405/android_device_samsung_n8013/tree/lineage-21.0) · [Releases](https://github.com/html6405/android_device_samsung_n8013/releases) | Not validated in this cycle; requires its own package and tests. |
| GT-N8020 | [Device tree](https://github.com/html6405/android_device_samsung_n8020/tree/lineage-21.0) · [Releases](https://github.com/html6405/android_device_samsung_n8020/releases) | Not validated in this cycle; separate LTE/modem and audio/device validation required. |

The release archives may contain other Android versions. Select a tag explicitly matching model and LineageOS21. The inspected LOS21 test unit is a 16 GB N8000 with 2 GiB SYSTEM, 500 MiB HIDDEN/VENDOR and 152 MiB CACHE, plus 8 MiB BOOT/recovery. This is actual LOS21 test geometry, not a copied LOS23 requirement or a minimum-size guarantee for every model. Recovery bytes stayed unchanged. ROM installation does not repartition automatically, and N8010/other layouts need their own verification.

N8000 release ZIP: [`lineage-21.0-20261121-HTML6405-n8000.zip`](https://github.com/html6405/android_device_samsung_n8000/releases/download/lineage-21.0-20261121/lineage-21.0-20261121-HTML6405-n8000.zip), **618141142 bytes**; [SHA-256 sidecar](https://github.com/html6405/android_device_samsung_n8000/releases/download/lineage-21.0-20261121/lineage-21.0-20261121-HTML6405-n8000.zip.sha256). SHA-256: `c1803dcfc5433d4c778882b640016dbacf00a3c791296d14f295f9e802d7eea3`. The release includes manifest/revision/source-supplement assets; its Git tag is a public device-tree baseline, not the complete compiled Android source tree.

## Shared compatibility areas

This tree supplies common tablet services and configuration, DT2W support, the preserved PID-based keyboard workaround, legacy GPS/audio integration, dock routing, partition initialization and scoped SELinux labels/rules. Per-model radio capabilities remain separate: N8000 cellular behavior is not applicable evidence for Wi-Fi-only N8010. Camera3 migration is deferred; LOS21 currently retains its legacy camera path.

Current N8000 evidence includes a no-wipe update, expected service domains under Enforcing, a corrected missing DT2W default, synthetic AVC crop/seek checks and verified fresh final OTA metadata. Earlier and temporary diagnostic software-HEVC tests show limited1080p performance and variable720p output (about27–43fps); the packaged candidate deliberately advertises no HEVC decoder, and that configuration was restored after testing. Green Prime preview lines nevertheless reappeared, so HEVC causality and a visual fix are not proved. Bluetooth call-audio source fixes still need repeated real LOS21 call tests. See the [N8000 changelog](https://github.com/html6405/android_device_samsung_n8000/blob/lineage-21.0/CHANGELOG.md) for exact known issues.

## Release coordination

Review local LOS23 commits and working-tree changes before issue fixes and release builds, adapting version-specific dependencies rather than copying them blindly. Keep original authorship and required workarounds. The current N8000 publication is explicitly experimental with disclosed remaining crashes and visual issues; a release entry must not imply a stable build or all functions passing.

For each accepted model release, maintain a distinct `lineage-21.0-YYYYMMDD` tag in its own repository, exact ROM/checksum links, source revision/manifest/supplement provenance and model-specific test limits. Update the device README/changelog, then this overview. The final N8000 metadata now has timestamp1795288401 and incremental `eng.html64.20261121.201321`; older stale-metadata test archives remain distinct. Security-patch level is still2024-08-05. Updater release/changelog links and automatic feed delivery require separate verification.

The central Exynos4 work order is N8000, then N8010. Shared source changes require an explicit per-model test record; source inheritance alone is not proof that a feature works on every tablet.
