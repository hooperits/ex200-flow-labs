# Implementation Plan: 07-local-storage

Detailed design for Module 07 - Local Storage.

## User Review Required
None. Standard design according to constitution.

## Proposed Changes

### Labs Folder

#### [NEW] [demo.sh](file:///home/juanca/proys/RHCSA-EX200/labs/07-local-storage/demo.sh)
Interactive local storage and LVM tutorial showing:
- Physical Volumes: `pvcreate`, `pvs`.
- Volume Groups: `vgcreate`, `vgs`, `vgextend`.
- Logical Volumes: `lvcreate -L -n`, `lvs`.
- Logical Volume Resizing: `lvextend -L -r`.
- LVM VDO: `lvcreate --type vdo --name myvdo -L 5G -V 10G myvg`.

#### [NEW] [instructions.md](file:///home/juanca/proys/RHCSA-EX200/labs/07-local-storage/instructions.md)
Detailed guidelines in Spanish for:
1. Creating a Volume Group `vg_labs` on a secondary disk device (e.g. `/dev/sdb` or `/dev/sdb1`).
2. Creating a Logical Volume `lv_docs` of size `800M` in `vg_labs`, formatted as `xfs`, and mounted persistently on `/mnt/docs` in `/etc/fstab`.
3. Creating a Logical Volume `lv_data` of size `500M`, then extending it to `1G` along with its filesystem in a single step using `lvextend -r`.
4. Creating a VDO volume named `vdo_vol` with a physical size of `4G` and virtual size of `8G` inside `vg_labs`, formatted as `xfs` and mounted on `/mnt/vdo`.

#### [NEW] [hints.md](file:///home/juanca/proys/RHCSA-EX200/labs/07-local-storage/hints.md)
Pistas for LVM creation, resizing, and VDO commands.

#### [NEW] [verify.sh](file:///home/juanca/proys/RHCSA-EX200/labs/07-local-storage/verify.sh)
Validates:
- `vg_labs` exists.
- `lv_docs` exists, is formatted as XFS, and mounted on `/mnt/docs` persistently.
- `lv_data` size is at least 1GB.
- VDO volume `vdo_vol` exists.

#### [NEW] [reset.sh](file:///home/juanca/proys/RHCSA-EX200/labs/07-local-storage/reset.sh)
Unmounts directories, removes entries from `/etc/fstab`, and wipes LVM configuration from secondary disks.

## Verification Plan

### Manual Verification
- Run verify.sh before solving (should fail).
- Solve the challenge and check verify.sh (should pass).
- Check demo.sh duration is at least 3 minutes.
