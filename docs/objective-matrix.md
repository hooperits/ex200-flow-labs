# RHCSA EX200 Objective Traceability Matrix - RHEL 10

**Purpose**: Map labs to official Red Hat EX200 objectives (RHEL 10 / AlmaLinux 10). This supports 90%+ coverage goal and verification of educational quality (Rule 1).

**Status**: Migración a RHEL 10 completada (strings limpios, julio 2026). 
- Basado en objetivos oficiales EX200 para RHEL 10.
- **Cambio importante**: "Manage containers" (Podman) fue **eliminado** de los objetivos del EX200 (se movió a examen separado).
- Lab 09 será removido o reemplazado en esta migración.
- Flatpak agregado al área de "Manage software".

**Source**: Official EX200 objectives from Red Hat (exam page + objective lists 2026).

## Current Coverage Summary (en migración RHEL 10)
- **Objetivo**: ≥ 90% de los objetivos oficiales EX200 para RHEL 10.
- **Nota clave**: Lab 09 (Podman) será removido porque el objetivo de contenedores fue eliminado del EX200.
- Cobertura actual en proceso de re-evaluación.
- Phase 0 completada: Decisiones tomadas (ver docs/RHEL10-decisions.md).
- Fase 1 en progreso: Actualización de infraestructura.

## Rough Coverage % by Lab (RHEL 10 - estimado en progreso)
- Lab 01 (Essential Tools): ~92%
- Lab 02 (Shell Scripting): ~75%
- Lab 03 (Operating Systems): ~80%
- Lab 04 (Users/Groups): ~85%
- Lab 05 (Networking): ~70%
- Lab 06 (SELinux): ~80%
- Lab 07 (Local Storage): ~75%
- Lab 08 (Filesystems/Network Storage): ~80%
- **Lab 09 (Podman)**: **Removido** (objetivo de contenedores eliminado del EX200)
- Lab 10 (Package Mgmt): ~90% (actualizar a dnf5 + Flatpak)
- Lab 11 (Logging): ~85%
- Lab 12 (SSH/Sudoers): ~88%
- Lab 13 (Kernel/sysctl): ~80%
- Lab 14 (Systemd Timers): ~90%
- Lab 15 (Troubleshooting): ~85%

**Nota**: Las coberturas serán recalculadas durante la migración.

## Lab to Objective Mapping (Summary)

**Lab 01: Essential Tools**
- Objectives: Use essential tools (grep, find, tar, etc.); file permissions/links; redirection/pipes.
- Coverage: High for basic system tools.
  - Sub: grep/find/tar, chmod/chown/links, > >> | , stat/readlink (from lab instructions).
  - Ref: Red Hat EX200 "Use essential tools" objective.

**Lab 02: Shell Scripting**
- Objectives: Write simple scripts; use loops, conditionals, variables.
- Coverage: Shell scripting basics.
  - Sub: bash basics, for/while, if/else, variables, #!/bin/bash (basic coverage).
  - Ref: Red Hat EX200 "Write simple shell scripts" (basic).

**Lab 03: Operating Systems**
- Objectives: Manage services (systemctl); targets; processes; logs (journalctl); boot recovery (rd.break, chroot).
- Coverage: System operation and recovery.
  - Sub: systemctl, targets, journalctl, processes (ps/kill); GRUB recovery noted as partial.
  - Ref: Red Hat EX200 "Manage system services and processes".

**Lab 04: Users and Groups**
- Objectives: Manage users/groups; permissions (ACLs, SGID).
- Coverage: User/group management.
  - Sub: useradd/usermod/groupadd, chown/chmod, setfacl/getfacl, SGID bits (from lab tasks).
  - Ref: Red Hat EX200 "Manage users and groups".

**Lab 05: Networking Services**
- Objectives: Configure networking (nmcli); hostname; time sync (chrony); cron.
- Coverage: Basic networking and services.
  - Sub: nmcli con add/mod, hostnamectl, chronyc, crontab -e (from instructions).
  - Ref: Red Hat EX200 "Configure networking and system services".

**Lab 06: Security - SELinux**
- Objectives: Manage SELinux (getenforce, setenforce, semanage, restorecon); Booleans; contexts.
- Coverage: SELinux management.
  - Sub: getenforce/setenforce, semanage fcontext/boolean, restorecon, getsebool/setsebool (typical lab).
  - Ref: Red Hat EX200 "Manage SELinux".

**Lab 07: Local Storage**
- Objectives: Manage partitions (fdisk/gdisk); LVM (pv/vg/lvcreate, extend); filesystems (mkfs, mount); VDO.
- Coverage: Storage management (LVM focus).
  - Sub: pvcreate/vgcreate/lvcreate/lvextend, mkfs.xfs, mount, vdo, fstab.

**Lab 08: Filesystems and Network Storage**
- Objectives: Configure fstab (UUID); autofs; NFS/SMB mounts.
- Coverage: Filesystem mounting and network storage.
  - Sub: blkid/UUID, fstab, autofs, NFS/SMB.

**Lab 09: Podman Containers**
- **Estado**: Removido del catálogo (Fase 2).
- Razón: El objetivo "Manage containers" fue eliminado de los objetivos oficiales del EX200 en RHEL 10.
- El row fue eliminado de la tabla en README.

**Lab 10: Package Management**
- Objectives: Manage software (dnf5, repositorios, RPM, Flatpak).
- Coverage: En proceso de actualización para dnf5 + Flatpak (RHEL 10).

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

## Detailed Examples (Sample) - Actualizando a RHEL 10
- Lab 10: dnf5 + Flatpak + repos locales - maps to "Manage software" (RHEL 10).
- Lab 11: journalctl -n/-u/-p/-b ... - maps to logging.
- Lab 12: SSH + sudoers.
- Lab 13: sysctl.
- Lab 14: systemd timers.
- Lab 15: Troubleshooting.
- **Lab 09 removido** (ver decisiones).
- Full update pending durante migración.

## Gaps and Next (Post RHEL 10 Migration)
- Matriz actualizada. Referencias v9 limpiadas.
- Lab 09 removido del catálogo.
- Flatpak incorporado en Lab 10.
- Phase 0-2 principales completadas.
- Siguiente: revisión completa de verifies para dnf5/otros comportamientos RHEL 10 + regen de skeletons.
- Target: 90%+ cobertura objetivos oficiales EX200 RHEL 10.

**Verification**: Esta matriz será revisada en cada fase de la migración.

*Actualizado el 2026-07-01 durante Fase 0.*