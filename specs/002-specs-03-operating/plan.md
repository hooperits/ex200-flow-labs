# Implementation Plan: 03-operating-systems

Detailed design for Module 03 - Operating Systems.

## User Review Required
None. Standard design according to constitution.

## Proposed Changes

### Labs Folder

#### [NEW] [demo.sh](file:///home/juanca/proys/RHCSA-EX200/labs/03-operating-systems/demo.sh)
Interactive systemd, process and logs tutorial showing:
- Managing services (`systemctl start/stop/enable/disable/status`).
- Modifying targets (`systemctl get-default`, `systemctl set-default`).
- Reviewing logs (`journalctl -u service`, `journalctl -p err`, `journalctl -n 10`).
- Process control (`ps aux`, `kill`, `nice`, `renice`).

#### [NEW] [instructions.md](file:///home/juanca/proys/RHCSA-EX200/labs/03-operating-systems/instructions.md)
Detailed guidelines in Spanish for:
1. Creating a custom systemd service `challenge/simple-web.service` that runs a tiny Python web server on port `8080`.
2. Setting the service to auto-start on boot.
3. Modifying the system default target to `multi-user.target`.
4. Explaining and writing the root password recovery steps in `challenge/root_recovery.txt`.

#### [NEW] [hints.md](file:///home/juanca/proys/RHCSA-EX200/labs/03-operating-systems/hints.md)
Pistas for systemd syntax, system target commands, and GRUB rd.break steps.

#### [NEW] [verify.sh](file:///home/juanca/proys/RHCSA-EX200/labs/03-operating-systems/verify.sh)
Validates that:
- `simple-web.service` is created, enabled, and running.
- Default system target is `multi-user.target`.
- `challenge/root_recovery.txt` exists and has the correct commands (`rd.break`, `remount,rw`, `chroot`, `passwd`, `autorelabel`).

#### [NEW] [reset.sh](file:///home/juanca/proys/RHCSA-EX200/labs/03-operating-systems/reset.sh)
Restores default target and disables/removes the systemd service.

## Verification Plan

### Manual Verification
- Run verify.sh before solving (should fail).
- Solve the challenge and check verify.sh (should pass).
- Check demo.sh duration is at least 3 minutes.
