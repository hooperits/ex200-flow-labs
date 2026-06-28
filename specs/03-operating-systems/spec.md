# Feature Specification: 03-operating-systems

**Feature Branch**: `03-operating-systems`  
**Created**: 2026-06-28  
**Status**: Draft  
**Input**: Tercer módulo de laboratorios y rap sobre la Operación del Sistema en Ejecución (systemd, procesos, journalctl y recuperación de contraseña de root en GRUB) para el examen RHCSA EX200 (RHEL 9).

## User Scenarios & Testing

### User Story 1 - Demo y Challenge Práctico (Priority: P1)
El estudiante aprende a gestionar servicios, procesos, ver logs con journalctl e interrumpir el arranque para recuperar el acceso root.

**Acceptance Scenarios**:
1. **Given** el reto, **When** el estudiante configure un servicio personalizado o cambie el target por defecto (`multi-user.target` vs `graphical.target`), **Then** `verify.sh` debe comprobar que el estado final del sistema refleje el cambio requerido.
2. **Given** la simulación de pérdida de contraseña, **When** el estudiante edite los parámetros de GRUB en el arranque y configure `rd.break` y monte de forma escrita en `/sysroot`, **Then** debe poder cambiar la contraseña de root de forma segura.

## Requirements
- **FR-001**: El laboratorio MUST detallar el flujo de recuperación de contraseña de root (`rd.break`, `mount -o remount,rw /sysroot`, `chroot /sysroot`, `passwd`, `touch /.autorelabel`).
- **FR-002**: El script `verify.sh` MUST validar el estado de los servicios (start/stop/enabled/disabled) y el target por defecto del sistema.
- **FR-003**: La letra de rap técnico en español MUST guardarse en `/home/juanca/RHCSA-EX200-lyrics/03-operating-systems.txt`, rimando la secuencia de recuperación de GRUB y comandos de systemd.
