# Feature Specification: 04-users-groups

**Feature Branch**: `04-users-groups`  
**Created**: 2026-06-28  
**Status**: Draft  

## User Scenarios & Testing

### User Story 1 - Demo y Challenge Práctico (Priority: P1)
El estudiante crea usuarios con configuraciones específicas (shell sin login, UID personalizado), gestiona grupos secundarios, configura directorios compartidos para grupos usando SGID, y asigna ACLs específicas.

**Acceptance Scenarios**:
1. **Given** un directorio de proyecto compartido para un grupo, **When** el estudiante aplique permisos `2770` (SGID) y ACLs finas con `setfacl`, **Then** los nuevos archivos creados deben heredar el grupo propietario y se debe respetar la visibilidad de los usuarios con ACLs.
2. **Given** la verificación, **When** se ejecute `verify.sh`, **Then** debe validar que los usuarios, sus contraseñas, grupos, la presencia de permisos SGID y las ACLs estén configurados de forma exacta a los requisitos del reto.

## Requirements
- **FR-001**: El laboratorio MUST contener demo y retos de creación de usuarios con UIDs específicos y expiración de contraseña (`chage`).
- **FR-002**: El laboratorio MUST cubrir el uso de SGID en directorios y Sticky Bit en `/tmp/` o directorios de carga común.
- **FR-003**: El script `verify.sh` MUST validar el archivo `/etc/passwd`, `/etc/group` y usar `getfacl` para verificar ACLs de forma no destructiva.
