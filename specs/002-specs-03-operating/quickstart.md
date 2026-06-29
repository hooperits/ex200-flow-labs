# Quickstart Guide: 03-operating-systems

Guide to run and solve Module 03.

## How to execute

1. SSH into the VM:
   ```powershell
   vagrant ssh
   ```
2. Navigate to directory:
   ```bash
   cd /labs/03-operating-systems/
   ```
3. Run the interactive demo:
   ```bash
   ./demo.sh
   ```
4. Solve the challenge:
   - Configure `/etc/systemd/system/simple-web.service`.
   - Start and enable the service.
   - Set the default boot target to `multi-user.target`.
   - Document the GRUB root recovery steps in `challenge/root_recovery.txt`.
5. Run the validator:
   ```bash
   ./verify.sh
   ```
