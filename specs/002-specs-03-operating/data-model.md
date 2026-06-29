# Data Model and Test Scenarios: 03-operating-systems

Layout of test inputs and outputs.

## Service name
- Service target: `simple-web.service`
- Service location: `/etc/systemd/system/simple-web.service`
- Run command: `/usr/bin/python3 -m http.server 8080` (or similar background server).

## Target configuration
- Default target check: must output `multi-user.target`.

## Password recovery steps check
- Verification script scans `/labs/03-operating-systems/challenge/root_recovery.txt` for keywords: `rd.break`, `remount,rw`, `/sysroot`, `chroot`, `passwd`, `/.autorelabel`.
