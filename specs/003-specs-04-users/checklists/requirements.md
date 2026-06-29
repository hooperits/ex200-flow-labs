# Requirements Checklist: 04-users-groups

Use this checklist to verify that all specifications are fully met.

## 📋 General Requirements
- [x] R-001: The feature directory has been resolved as `/specs/003-specs-04-users/`
- [x] R-002: The branch is `003-specs-04-users`
- [x] R-003: The lyrics file path is relative and portable `../RHCSA-EX200-lyrics/04-users-groups.txt`

## 📋 Functional Requirements (Module 04)
- [x] FR-001: `demo.sh` illustrates `useradd` (UID, secondary groups, non-login shell), `groupadd`, `chmod` for special permissions (SGID, Sticky Bit), and `setfacl` / `getfacl` for ACLs.
- [x] FR-002: `demo.sh` implements clear screen transitions between sections (`clear_section`).
- [x] FR-003: `demo.sh` runs for at least 3 minutes (180 seconds) with appropriate typing and post-execution pauses.
- [x] FR-004: `instructions.md` details the challenge requirements in Spanish (creating a user and group, setting up a shared group directory with SGID, and adding specific read/write ACLs for a third-party user).
- [x] FR-005: `hints.md` provides progressive clues to solve the challenge.
- [x] FR-006: `verify.sh` automatically evaluates user, group, SGID, and ACL configurations.
- [x] FR-007: `reset.sh` cleans up created users, groups, and directories.
- [x] FR-008: Mnemotechnic lyrics are saved externally in `../RHCSA-EX200-lyrics/04-users-groups.txt` in Spanish.
