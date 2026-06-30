# RHCSA EX200 Objective Traceability Matrix (Initial)

**Purpose**: Map labs to official Red Hat EX200 objectives (RHEL 9 / AlmaLinux 9). This supports 90%+ coverage goal and verification of educational quality (Rule 1).

**Status**: Initial draft (2026-06-30). Based on current labs 01-15. To be expanded with full details, percentages, and updates after each lab.

**Source**: Official EX200 objectives (e.g., from Red Hat docs: system management, storage, networking, security, containers, etc.).

## Current Coverage Summary
- Estimated: ~83% (avg from per-lab table; 9 original + 6 new labs full detailed; improved mapping for packages, logging, SSH, kernel, timers, troubleshooting).
- Phase 0/1 progress: Verifiers --explain all, resets shared all, Phase1 instructions 10-15 complete (detailed like lab 10).
- Full matrix to be completed (sub-objs, % per lab). Phase1 instructions deliverable done.

## Rough Coverage % by Lab (estimated, based on mapped objectives)
- Lab 01 (Essential Tools): 92% (core tools, perms, redirection strong)
- Lab 02 (Shell Scripting): 75% (basics; more advanced scripting gaps)
- Lab 03 (Operating Systems): 80% (services, logs, targets; boot recovery partial)
- Lab 04 (Users/Groups): 85%
- Lab 05 (Networking): 70% (basic nmcli, chrony, cron)
- Lab 06 (SELinux): 80%
- Lab 07 (Local Storage): 75% (LVM/VDO; partition tools good)
- Lab 08 (Filesystems/Network Storage): 80%
- Lab 09 (Podman): 85%
- Lab 10 (Package Mgmt): 90% (full dnf, repos, modules)
- Lab 11 (Logging): 85% (journalctl, rsyslog, persistence)
- Lab 12 (SSH/Sudoers): 88% (keys, sudoers, sshd config)
- Lab 13 (Kernel/sysctl): 80%
- Lab 14 (Systemd Timers): 90%
- Lab 15 (Troubleshooting): 85% (diagnostics across areas)

## Lab to Objective Mapping (Summary)

**Lab 01: Essential Tools**
- Objectives: Use essential tools (grep, find, tar, etc.); file permissions/links; redirection/pipes.
- Coverage: High for basic system tools.
  - Sub: grep/find/tar, chmod/chown/links, > >> | , stat/readlink (from lab instructions).

**Lab 02: Shell Scripting**
- Objectives: Write simple scripts; use loops, conditionals, variables.
- Coverage: Shell scripting basics.
  - Sub: bash basics, for/while, if/else, variables, #!/bin/bash (basic coverage).

**Lab 03: Operating Systems**
- Objectives: Manage services (systemctl); targets; processes; logs (journalctl); boot recovery (rd.break, chroot).
- Coverage: System operation and recovery.
  - Sub: systemctl, targets, journalctl, processes (ps/kill); GRUB recovery noted as partial.

**Lab 04: Users and Groups**
- Objectives: Manage users/groups; permissions (ACLs, SGID).
- Coverage: User/group management.
  - Sub: useradd/usermod, group, chown/chmod, ACLs (setfacl/getfacl), SGID.

**Lab 05: Networking Services**
- Objectives: Configure networking (nmcli); hostname; time sync (chrony); cron.
- Coverage: Basic networking and services.
  - Sub: nmcli, hostnamectl, chrony, crontab.

**Lab 06: Security - SELinux**
- Objectives: Manage SELinux (getenforce, setenforce, semanage, restorecon); Booleans; contexts.
- Coverage: SELinux management.
  - Sub: getenforce/setenforce, semanage, restorecon, booleans.

**Lab 07: Local Storage**
- Objectives: Manage partitions (fdisk/gdisk); LVM (pv/vg/lvcreate, extend); filesystems (mkfs, mount); VDO.
- Coverage: Storage management (LVM focus).
  - Sub: pvcreate/vgcreate/lvcreate/lvextend, mkfs.xfs, mount, vdo, fstab.

**Lab 08: Filesystems and Network Storage**
- Objectives: Configure fstab (UUID); autofs; NFS/SMB mounts.
- Coverage: Filesystem mounting and network storage.
  - Sub: blkid/UUID, fstab, autofs, NFS/SMB.

**Lab 09: Podman Containers**
- Objectives: Manage containers (podman); rootless; systemd integration (linger, user services).
- Coverage: Container management with Podman.
  - Sub: podman run/ps/exec, rootless, systemd user services.

**Lab 10: Package Management**
- Objectives: Manage packages (dnf/yum); repositories; modules (AppStreams).
- Coverage: Package and repo management.

**Lab 11: Logging**
- Objectives: Manage logs (journalctl filters, -b, -p, -u); rsyslog config; journald persistent (Storage=persistent).
- Coverage: Advanced logging. Instructions now full detailed (2026-06-30).

**Lab 12: SSH, Keys & Sudoers**
- Objectives: SSH keys (ssh-keygen, authorized_keys), sudoers.d, sshd_config restrict (PermitRootLogin).
- Coverage: Secure access and privilege management. Instructions now full detailed (2026-06-30).

**Lab 13: Kernel / sysctl**
- Objectives: Kernel parameters (sysctl -a/-w, /etc/sysctl.d/, /proc/sys); tuning.
- Coverage: Basic kernel management. Instructions now full detailed matching lab 10 (2026-06-30).

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
- Lab 10: dnf install/remove, repo config (local-test.repo), modules (nodejs) - maps to "Manage software" objective.
- Lab 11: journalctl -n/-u/-p/-b, mkdir /var/log/journal + sed Storage=persistent + restart, rsyslog rule + logger - maps to "Configure logging".
- Lab 12: ssh-keygen + authorized_keys + chmod, /etc/sudoers.d/ + visudo, sed PermitRootLogin no + restart sshd - maps to "Manage user access and security".
- Lab 13: sysctl -a | grep, sysctl -w (temp), /etc/sysctl.d/ + sysctl -p, /proc/sys/ checks - maps to "Kernel tuning".
- Lab 14: .service + .timer units, systemctl enable --now + list-timers, disable + daemon-reload - maps to "Manage systemd units and timers".
- Lab 15: journalctl -u/sshd, ls/chmod fixes, ip addr + ss -tuln, logger + document in challenge/ - maps to "Troubleshoot".
- Full details to be filled per lab (add links/official refs next).

## Gaps and Next
- Full matrix: Add official EX200 links (e.g. from Red Hat EX200 objectives doc), exact % calcs, more subs.
- Phase1 instructions complete for 10-15; detailed examples + sub-objs for 01-09 expanded.
- Next: full Vagrant tests (persistence), expand matrix (links), full re-audit, CLI.
- Target: 90%+ with traceability. Update per process.

**Verification**: This matrix will be reviewed in post-task checklists and re-audits.

*Update this after each major lab or Phase.*