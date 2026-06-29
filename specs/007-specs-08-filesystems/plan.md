# Implementation Plan: 08-filesystems-network

Detailed design for Module 08 - Filesystems and Network Mounts.

## User Review Required
None. Standard design according to constitution.

## Proposed Changes

### Labs Folder

#### [NEW] [demo.sh](file:///home/juanca/proys/RHCSA-EX200/labs/08-filesystems-network/demo.sh)
Interactive filesystems and autofs tutorial showing:
- File Systems: `mkfs.ext4`, `blkid`, `findmnt`.
- Mounting: `mount`, `umount`.
- Autofs: `systemctl status autofs`, `/etc/auto.master`, mapping files.
- Testing automount: accessing directory triggering mount.

#### [NEW] [instructions.md](file:///home/juanca/proys/RHCSA-EX200/labs/08-filesystems-network/instructions.md)
Detailed guidelines in Spanish for:
1. Identifying UUID of disk device (e.g. partition `/dev/sdb1` if configured, or we can use a loopback file block device created for the lab) and mounting it on `/mnt/data_local` using **UUID** in `/etc/fstab`.
2. Configuring `autofs` to automount a shared directory:
   - Master map `/etc/auto.master` must specify `/shares` as parent directory and `/etc/auto.shares` as map.
   - Map `/etc/auto.shares` must map key `nfs_share` to mount a local simulated NFS directory `/srv/nfs_export` (mount syntax: `-fstype=nfs,rw localhost:/srv/nfs_export`).
   - Starting/enabling `autofs`.

#### [NEW] [hints.md](file:///home/juanca/proys/RHCSA-EX200/labs/08-filesystems-network/hints.md)
Pistas for `blkid`, `/etc/fstab` structure, and autofs maps configuration.

#### [NEW] [verify.sh](file:///home/juanca/proys/RHCSA-EX200/labs/08-filesystems-network/verify.sh)
Validates:
- `/etc/fstab` contains an entry with `UUID=` mounting on `/mnt/data_local`.
- Autofs daemon is active and enabled.
- Accessing `/shares/nfs_share` triggers the mount of `localhost:/srv/nfs_export`.

#### [NEW] [reset.sh](file:///home/juanca/proys/RHCSA-EX200/labs/08-filesystems-network/reset.sh)
Cleans up `/etc/fstab` entries, stops autofs, removes map files, and deletes mountpoints.

## Verification Plan

### Manual Verification
- Run verify.sh before solving (should fail).
- Solve the challenge and check verify.sh (should pass).
- Check demo.sh duration is at least 3 minutes.
