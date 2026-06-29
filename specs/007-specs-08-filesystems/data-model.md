# Data Model and Test Scenarios: 08-filesystems-network

Layout of test inputs and outputs.

## Local Mount
- Device file or loopback device representing local filesystem.
- Target mountpoint: `/mnt/data_local`
- Must use UUID in `/etc/fstab`.

## Autofs Mount
- Parent directory: `/shares`
- Mount target directory: `/shares/nfs_share`
- Target NFS export: `localhost:/srv/nfs_export`
