# Quickstart Guide: 08-filesystems-network

Guide to run and solve Module 08.

## How to execute

1. SSH into the VM:
   ```powershell
   vagrant ssh
   ```
2. Navigate to directory:
   ```bash
   cd /labs/08-filesystems-network/
   ```
3. Run the interactive demo:
   ```bash
   ./demo.sh
   ```
4. Solve the challenge:
   - Identify UUID of partition (e.g. `/dev/sdb1`).
   - Create `/mnt/data_local`.
   - Add entry `UUID=... /mnt/data_local ext4 defaults 0 0` in `/etc/fstab` and mount it: `sudo mount -a`.
   - Install autofs: `sudo dnf install -y autofs`.
   - Add `/shares /etc/auto.shares` in `/etc/auto.master`.
   - Create `/etc/auto.shares` with `nfs_share -fstype=nfs,rw localhost:/srv/nfs_export`.
   - Run `sudo systemctl enable --now autofs`.
   - Verify mounting: `cd /shares/nfs_share`.
5. Run the validator:
   ```bash
   ./verify.sh
   ```
