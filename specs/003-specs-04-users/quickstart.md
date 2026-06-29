# Quickstart Guide: 04-users-groups

Guide to run and solve Module 04.

## How to execute

1. SSH into the VM:
   ```powershell
   vagrant ssh
   ```
2. Navigate to directory:
   ```bash
   cd /labs/04-users-groups/
   ```
3. Run the interactive demo:
   ```bash
   ./demo.sh
   ```
4. Solve the challenge:
   - Create group `sysadmin`.
   - Create user `operator1` with secondary group `sysadmin` and shell `/sbin/nologin`.
   - Create user `auditor1`.
   - Create directory `/srv/sysadmin_docs`.
   - Configure ownership and group permissions of the directory with SGID.
   - Configure ACL for `auditor1` to have read-only permissions on the directory.
5. Run the validator:
   ```bash
   ./verify.sh
   ```
