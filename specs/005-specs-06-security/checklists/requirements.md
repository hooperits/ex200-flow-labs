# Requirements Checklist: 06-security-selinux

Use this checklist to verify that all specifications are fully met.

## 📋 General Requirements
- [x] R-001: The feature directory has been resolved as `/specs/005-specs-06-security/`
- [x] R-002: The branch is `005-specs-06-security`
- [x] R-003: The lyrics file path is relative and portable `../RHCSA-EX200-lyrics/06-security-selinux.txt`

## 📋 Functional Requirements (Module 06)
- [x] FR-001: `demo.sh` illustrates `firewall-cmd` (list all, add port, add service, rich rules), `semanage` (file contexts, ports), `restorecon`, and `getsebool`/`setsebool` (SELinux booleans).
- [x] FR-002: `demo.sh` implements clear screen transitions between sections (`clear_section`).
- [x] FR-003: `demo.sh` runs for at least 3 minutes (180 seconds) with appropriate typing and post-execution pauses.
- [x] FR-004: `instructions.md` details the challenge requirements in Spanish (configuring firewalld rules for service and port, modifying file contexts for a custom web directory to `httpd_sys_content_t`, and enabling an HTTP SELinux boolean).
- [x] FR-005: `hints.md` provides progressive clues to solve the challenge.
- [x] FR-006: `verify.sh` automatically evaluates firewalld rules, folder contexts, and SELinux boolean states.
- [x] FR-007: `reset.sh` cleans up firewall rules and restores folder contexts.
- [x] FR-008: Mnemotechnic lyrics are saved externally in `../RHCSA-EX200-lyrics/06-security-selinux.txt` in Spanish.
