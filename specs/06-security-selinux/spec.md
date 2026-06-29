# Feature Specification: 06-security-selinux

**Feature Branch**: `06-security-selinux`  
**Created**: 2026-06-28  
**Status**: Draft  

## User Scenarios & Testing

### User Story 1 - Demo y Challenge Práctico (Priority: P1)
El estudiante configura zonas, puertos y servicios en firewalld (incluyendo reglas ricas/rich rules), y soluciona un problema de bloqueo de un servicio (ej. servidor web Apache corriendo en puerto no estándar) modificando el contexto de archivos y puertos en SELinux.

**Acceptance Scenarios**:
1. **Given** un servicio bloqueado por SELinux, **When** el estudiante cambie el tipo de contexto del archivo con `semanage fcontext` y `restorecon`, y configure el puerto en SELinux con `semanage port`, **Then** el servicio debe iniciarse y ser accesible.
2. **Given** el firewall, **When** el estudiante habilite el servicio y recargue con `firewall-cmd --reload`, **Then** `verify.sh` debe comprobar que las reglas persistan tras el reinicio del sistema (usando `--permanent`).

## Requirements
- **FR-001**: El laboratorio MUST contener retos de agregar puertos, servicios y reglas rich en `firewalld`.
- **FR-002**: El laboratorio MUST simular un problema real de SELinux (ej. Apache bloqueado) para que el estudiante use `semanage fcontext`, `restorecon` y booleanos (`setsebool -P`).
- **FR-003**: El script `verify.sh` MUST validar el estado del firewall (`firewall-cmd --list-all`) y los contextos de SELinux (`ls -Z` o `semanage`) de forma no destructiva.
