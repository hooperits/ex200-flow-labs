# Quickstart Guide: 05-networking-services

Guide to run and solve Module 05.

## How to execute

1. SSH into the VM:
   ```powershell
   vagrant ssh
   ```
2. Navigate to directory:
   ```bash
   cd /labs/05-networking-services/
   ```
3. Run the interactive demo:
   ```bash
   ./demo.sh
   ```
4. Solve the challenge:
   - Run `sudo hostnamectl set-hostname rhcsa-server`.
   - Update connection settings using `nmcli`.
   - Add `server pool.ntp.org iburst` to `/etc/chrony.conf` and restart chronyd.
   - Run `crontab -e` and add `0 3 * * 1 echo "RHCSA Examen" >> /tmp/cron_test.txt`.
5. Run the validator:
   ```bash
   ./verify.sh
   ```
