# Implementation Plan: 05-networking-services

Detailed design for Module 05 - Networking Services.

## User Review Required
None. Standard design according to constitution.

## Proposed Changes

### Labs Folder

#### [NEW] [demo.sh](file:///home/juanca/proys/RHCSA-EX200/labs/05-networking-services/demo.sh)
Interactive networking and scheduling tutorial showing:
- Network management: `nmcli device`, `nmcli connection show`, `nmcli connection mod`.
- Hostname: `hostnamectl status`, `hostnamectl set-hostname`.
- NTP: `chronyc tracking`, `chronyc sources`.
- Task scheduling: `crontab -l`, `crontab -e` (examples), `/etc/cron.d/` syntax.

#### [NEW] [instructions.md](file:///home/juanca/proys/RHCSA-EX200/labs/05-networking-services/instructions.md)
Detailed guidelines in Spanish for:
1. Setting system hostname to `rhcsa-server`.
2. Configuring `eth1` (or local secondary connection) to have static IP `192.168.56.20/24`, gateway `192.168.56.1`, and DNS `8.8.8.8`.
3. Adding NTP server `pool.ntp.org` to `/etc/chrony.conf` and restarting chronyd.
4. Creating a crontab entry for user `vagrant` that runs a command `echo "RHCSA Examen" >> /tmp/cron_test.txt` every Monday at 3:00 AM (`0 3 * * 1`).

#### [NEW] [hints.md](file:///home/juanca/proys/RHCSA-EX200/labs/05-networking-services/hints.md)
Pistas for `nmcli`, `chrony.conf`, and cron formatting.

#### [NEW] [verify.sh](file:///home/juanca/proys/RHCSA-EX200/labs/05-networking-services/verify.sh)
Validates:
- Hostname is set to `rhcsa-server` (or contains it).
- Ethernet connection `eth1` (or similar interface) has correct static IP.
- `/etc/chrony.conf` has `pool.ntp.org`.
- User `vagrant` has cron job `0 3 * * 1 ...`.

#### [NEW] [reset.sh](file:///home/juanca/proys/RHCSA-EX200/labs/05-networking-services/reset.sh)
Restores original hostname, connection to dhcp, and deletes cron jobs.

## Verification Plan

### Manual Verification
- Run verify.sh before solving (should fail).
- Solve the challenge and check verify.sh (should pass).
- Check demo.sh duration is at least 3 minutes.
