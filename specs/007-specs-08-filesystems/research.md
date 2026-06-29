# Research Notes: 08-filesystems-network

Analysis of networking mounts and autofs on RHEL 9 VM.

## blkid and fstab
To get partition UUID:
```bash
blkid /dev/sdb1
```
Add to `/etc/fstab`:
```text
UUID=xxxx-xxxx-xxxx-xxxx  /mnt/data_local  ext4  defaults  0 0
```

## Autofs Configuration
Install package:
```bash
dnf install -y autofs
```
Create master map entry in `/etc/auto.master`:
```text
/shares  /etc/auto.shares
```
Create map file `/etc/auto.shares`:
```text
nfs_share  -fstype=nfs,rw  localhost:/srv/nfs_export
```
Run:
```bash
systemctl enable --now autofs
```
Testing is done by changing directory:
```bash
cd /shares/nfs_share
```
The autofs kernel module will dynamically mount the NFS share on demand.
