# Copyright (C) 2026 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

"""The n80xx OTA needs no device-specific partition maintenance.

System-as-root and vendor block images already contain their complete layout.
Do not run filesystem checks or resize userdata from a ZIP stored on userdata;
normal fstab checks run before the filesystem is mounted during boot.
"""
