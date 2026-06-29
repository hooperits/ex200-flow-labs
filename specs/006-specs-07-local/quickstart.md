# Quickstart Guide: 07-local-storage

Guide to run and solve Module 07.

## How to execute

1. SSH into the VM:
   ```powershell
   vagrant ssh
   ```
2. Navigate to directory:
   ```bash
   cd /labs/07-local-storage/
   ```
3. Run the interactive demo:
   ```bash
   ./demo.sh
   ```
4. Solve the challenge:
   - Identify secondary disk (e.g. `/dev/sdb`).
   - Run `pvcreate /dev/sdb` and `vgcreate vg_labs /dev/sdb`.
   - Run `lvcreate -L 800M -n lv_docs vg_labs` and format: `mkfs.xfs /dev/vg_labs/lv_docs`.
   - Mount it: `sudo mkdir -p /mnt/docs`, add to `/etc/fstab`, and run `mount -a`.
   - Run `lvcreate -L 500M -n lv_data vg_labs` and format. Then extend it: `lvextend -L 1G -r /dev/vg_labs/lv_data`.
   - Create VDO: `lvcreate --type vdo --name vdo_vol -L 4G -V 8G vg_labs`.
5. Run the validator:
   ```bash
   ./verify.sh
   ```
