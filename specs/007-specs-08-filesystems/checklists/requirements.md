# Requirements Checklist: 08-filesystems-network

Use this checklist to verify that all specifications are fully met.

## 📋 General Requirements
- [x] R-001: The feature directory has been resolved as `/specs/007-specs-08-filesystems/`
- [x] R-002: The branch is `007-specs-08-filesystems`

## 📋 Functional Requirements (Module 08)
- [x] FR-001: `demo.sh` illustrates file systems (`mkfs.ext4`, `blkid`), persistent mounts using UUIDs, network mounting, and Autofs (`auto.master`, `auto.misc`).
- [x] FR-002: `demo.sh` implements clear screen transitions between sections (`clear_section`).
- [x] FR-003: `demo.sh` runs for at least 3 minutes (180 seconds) with appropriate typing and post-execution pauses.
- [x] FR-004: `instructions.md` details the challenge requirements in Spanish (identifying UUID and adding a persistent fstab mount, installing autofs, configuring a master and secondary map for automounting a local simulated NFS directory).
- [x] FR-005: `hints.md` provides progressive clues to solve the challenge.
- [x] FR-006: `verify.sh` automatically evaluates fstab mount entry (checking UUID format) and autofs mount status.
- [x] FR-007: `reset.sh` cleans up autofs configs, stops autofs service, and removes mountpoints.
