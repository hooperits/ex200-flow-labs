# Feature Specification: 08-filesystems-network

**Feature Branch**: `08-filesystems-network`  
**Created**: 2026-06-28  
**Status**: Draft  

## User Scenarios & Testing

### User Story 1 - Demo y Challenge Práctico (Priority: P1)
El estudiante formatea volúmenes locales en XFS/ext4 y los monta persistentemente. Además, configura la VM para conectarse a un recurso de red (NFS o SMB) y configura `autofs` para que se monte de manera automática y dinámica cuando el usuario acceda al directorio.

**Acceptance Scenarios**:
1. **Given** un recurso compartido en red, **When** el estudiante configure `autofs` escribiendo el mapa maestro `/etc/auto.master` y el mapa secundario `/etc/auto.misc`, **Then** el recurso debe montarse automáticamente al hacer `cd` al directorio mapeado.
2. **Given** la verificación, **When** se ejecute `verify.sh`, **Then** debe validar la correcta entrada en `/etc/fstab` (usando UUID en lugar de path del dispositivo) y el correcto funcionamiento del montaje automático de autofs.

## Requirements
- **FR-001**: El laboratorio MUST requerir el formateo e identificación del UUID de los discos (`blkid`).
- **FR-002**: El laboratorio MUST simular o proveer un servidor NFS/SMB local en la VM para permitir el ejercicio de montaje de red y autofs.
- **FR-003**: El script `verify.sh` MUST validar `/etc/fstab` y simular el acceso al directorio para forzar el montaje de `autofs` y corroborar que esté activo.
