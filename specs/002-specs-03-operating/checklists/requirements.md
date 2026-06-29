# Requirements Checklist: 03-operating-systems

Use this checklist to verify that all specifications are fully met.

## 📋 General Requirements
- [x] R-001: The feature directory has been resolved as `/specs/002-specs-03-operating/`
- [x] R-002: The branch is `002-specs-03-operating`

## 📋 Functional Requirements (Module 03)
- [x] FR-001: `demo.sh` illustrates `systemctl` (start/stop/enable/disable services, changing target), process management (`kill`, `nice`), and system logs (`journalctl`).
- [x] FR-002: `demo.sh` implements clear screen transitions between sections (`clear_section`).
- [x] FR-003: `demo.sh` runs for at least 3 minutes (180 seconds) with appropriate typing and post-execution pauses.
- [x] FR-004: `instructions.md` details the challenge requirements in Spanish (configuring a custom systemd service, changing system target, and documenting the password recovery process).
- [x] FR-005: `hints.md` provides progressive clues to solve the challenge.
- [x] FR-006: `verify.sh` automatically evaluates service state and target configurations.
- [x] FR-007: `reset.sh` cleans up custom service files and restores system target.
