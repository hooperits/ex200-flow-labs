# Research Notes: 07-local-storage

Analysis of storage partitioning and LVM on RHEL 9 VM.

## LVM Creation Commands
1. Physical Volume: `pvcreate /dev/sdb`
2. Volume Group: `vgcreate vg_labs /dev/sdb`
3. Logical Volume: `lvcreate -L 800M -n lv_docs vg_labs`
4. Format: `mkfs.xfs /dev/vg_labs/lv_docs`

## LVM Resizing in Hot
To resize the logical volume and its underlying filesystem (XFS or ext4) in a single command, use `lvextend` with the `-r` (resizefs) flag:
```bash
lvextend -L 1G -r /dev/vg_labs/lv_data
```

## LVM VDO (Virtual Data Optimizer)
LVM VDO is native in RHEL 9 (replacing standalone VDO). Command to create VDO volume in LVM:
```bash
lvcreate --type vdo --name vdo_vol -L 4G -V 8G vg_labs
```
Parameters:
- `-L 4G`: Physical size allocated to VDO pool.
- `-V 8G`: Virtual (deduplicated/compressed) size presented to the OS.
- `--type vdo`: VDO optimizer.
