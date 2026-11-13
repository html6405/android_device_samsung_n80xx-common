# Samsung Exynos4 N80xx shared device configuration

Shared device configuration and compatibility support for the Samsung Galaxy Note 10.1 family.

## LineageOS 23.2 releases

ROMs are published in each device repository so downloads, checksums, requirements, and test status stay specific to the model. The shared tree links to each model's release page:

| Model | Release page | LOS 23.2 status |
| --- | --- | --- |
| GT-N8000 | [Downloads and release notes](https://github.com/html6405/android_device_samsung_n8000/releases) | Experimental build available; tested on one 32 GB device. |
| GT-N8010 | [Downloads](https://github.com/html6405/android_device_samsung_n8010/releases) | No LOS 23.2 ROM release yet. |
| GT-N8013 | [Downloads](https://github.com/html6405/android_device_samsung_n8013/releases) | No LOS 23.2 ROM release yet. |
| GT-N8020 | [Downloads](https://github.com/html6405/android_device_samsung_n8020/releases) | No LOS 23.2 ROM release yet; separate modem/device validation is required. |

The N8000 ROM requires a prepared **2 GiB SYSTEM / 152 MiB CACHE** layout. The separate [N80xx repartitioning project](https://github.com/html6405/n80xx-repartition/releases) documents supported layouts and risks. Read its device-specific notes before use; repartitioning is not part of ROM updates.

## Shared compatibility areas

This tree contains shared Exynos4-family support for legacy Samsung radio and GPS components, graphics properties, USB configuration, audio docks, WebView GLES2 compatibility, and related device services. Device-specific release notes identify which functions were built and tested for each model.

Contributions should target the `lineage-23.2` branch and retain original commit authorship when porting upstream fixes.
