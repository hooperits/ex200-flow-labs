# Requirements Checklist: 05-networking-services

Use this checklist to verify that all specifications are fully met.

## 📋 General Requirements
- [x] R-001: The feature directory has been resolved as `/specs/004-specs-05-networking/`
- [x] R-002: The branch is `004-specs-05-networking`

## 📋 Functional Requirements (Module 05)
- [x] FR-001: `demo.sh` illustrates `nmcli` (connection modify, dynamic vs static, show), `hostnamectl`, `chronyc` (sources, tracking), and `crontab` task creation.
- [x] FR-002: `demo.sh` implements clear screen transitions between sections (`clear_section`).
- [x] FR-003: `demo.sh` runs for at least 3 minutes (180 seconds) with appropriate typing and post-execution pauses.
- [x] FR-004: `instructions.md` details the challenge requirements in Spanish (configuring static networking using `nmcli`, setting system hostname, configuring NTP peer in `chrony.conf`, and scheduling a cron job).
- [x] FR-005: `hints.md` provides progressive clues to solve the challenge.
- [x] FR-006: `verify.sh` automatically evaluates static network, hostname, chrony sources, and cron entries.
- [x] FR-007: `reset.sh` cleans up network interfaces and system cron jobs.
