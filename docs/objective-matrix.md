# RHCSA EX200 Objective Traceability Matrix (Initial)

**Purpose**: Map labs to official Red Hat EX200 objectives (RHEL 9 / AlmaLinux 9). This supports 90%+ coverage goal and verification of educational quality (Rule 1).

**Status**: Initial draft (2026-06-30). Based on current labs 01-15. To be expanded with full details, percentages, and updates after each lab.

**Source**: Official EX200 objectives (e.g., from Red Hat docs: system management, storage, networking, security, containers, etc.).

## Current Coverage Summary
- Estimated: ~60-70% (with 9 original + 6 new labs; gaps in advanced topics like kernel tuning full, advanced networking).
- Phase 0/1 progress: Verifiers/resets improved, new labs added for packages, logging, SSH, kernel, timers, troubleshooting.
- Full matrix to be completed in Phase 1 deliverable.

## Lab to Objective Mapping (Summary)

**Lab 01: Essential Tools**
- Objectives: Use essential tools (grep, find, tar, etc.); file permissions/links; redirection/pipes.
- Coverage: High for basic system tools.

**Lab 02: Shell Scripting**
- Objectives: Write simple scripts; use loops, conditionals, variables.
- Coverage: Shell scripting basics.

**Lab 03: Operating Systems**
- Objectives: Manage services (systemctl); targets; processes; logs (journalctl); boot recovery (rd.break, chroot).
- Coverage: System operation and recovery.

**Lab 04: Users and Groups**
- Objectives: Manage users/groups; permissions (ACLs, SGID).
- Coverage: User/group management.

**Lab 05: Networking Services**
- Objectives: Configure networking (nmcli); hostname; time sync (chrony); cron.
- Coverage: Basic networking and services.

**Lab 06: Security - SELinux**
- Objectives: Manage SELinux (getenforce, setenforce, semanage, restorecon); Booleans; contexts.
- Coverage: SELinux management.

**Lab 07: Local Storage**
- Objectives: Manage partitions (fdisk/gdisk); LVM (pv/vg/lvcreate, extend); filesystems (mkfs, mount); VDO.
- Coverage: Storage management (LVM focus).

**Lab 08: Filesystems and Network Storage**
- Objectives: Configure fstab (UUID); autofs; NFS/SMB mounts.
- Coverage: Filesystem mounting and network storage.

**Lab 09: Podman Containers**
- Objectives: Manage containers (podman); rootless; systemd integration (linger, user services).
- Coverage: Container management with Podman.

**Lab 10: Package Management**
- Objectives: Manage packages (dnf/yum); repositories; modules (AppStreams).
- Coverage: Package and repo management.

**Lab 11: Logging**
- Objectives: Manage logs (journalctl); rsyslog config; persistence.
- Coverage: Advanced logging.

**Lab 12: SSH, Keys & Sudoers**
- Objectives: SSH config (keys, sshd_config); sudoers; user access.
- Coverage: Secure access and privilege management.

**Lab 13: Kernel / sysctl**
- Objectives: Kernel parameters (sysctl); tuning.
- Coverage: Basic kernel management.

**Lab 14: Systemd Timers**
- Objectives: Systemd units and timers (create .timer/.service, enable, list-timers).
- Coverage: Advanced systemd. Instructions enhanced with detailed commands (2026-06-30).

**Lab 15: Troubleshooting**
- Objectives: Diagnostic tools (journalctl, systemctl, ip, ss); resolve common issues (services, permissions, network).
- Coverage: Troubleshooting scenarios. Enhanced instructions with detailed real-command steps (2026-06-30).

**Lab 11-14 additional**:
- 11 Logging: journalctl, rsyslog - advanced logging objective.
- 12 SSH: keys, sudoers - secure access.
- 13 Kernel: sysctl - parameters/tuning.
- 14 Timers: systemd timers - advanced units.

**CLI test note**: bin/ex200 verify 15-troubleshooting --explain works (calls verify, shows troubleshooting suggestions).

**Enhance notes**: Lab 14 demo enhanced with list timers; lab 15 with extra network. Generators run. Lab 13 with /proc check.

## Detailed Examples (Sample)
- Lab 10: dnf install/remove, repo config, modules - maps to "Manage software" objective.
- Lab 13: sysctl -w/p, /proc/sys - maps to "Kernel tuning".
- Full details to be filled per lab.

## Gaps and Next
- Full matrix: Add detailed sub-objectives, % coverage, links to official docs.
- Remaining Phase 1/2: Add labs for more (e.g., advanced security if needed), exam sim.
- Update after each lab change per sync process.
- Target: 90%+ with traceability.

**Verification**: This matrix will be reviewed in post-task checklists and re-audits.

*Update this after each major lab or Phase.*