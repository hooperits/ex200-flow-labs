# Data Model and Test Scenarios: 07-local-storage

Layout of test inputs and outputs.

## LVM Components
- Volume Group: `vg_labs`
- Logical Volume 1: `lv_docs` (size: `800M`, mount: `/mnt/docs`, format: `xfs`)
- Logical Volume 2: `lv_data` (size: `1G`, format: `xfs` or `ext4`)
- LVM VDO: `vdo_vol` (physical size: `4G`, virtual size: `8G`, pool name: `vdo_vol-vpool`)

## Mount Target
- Persistent mount in `/etc/fstab` for `/mnt/docs` and `/mnt/vdo`.
