# Feature Specification: 07-local-storage

**Feature Branch**: `07-local-storage`  
**Created**: 2026-06-28  
**Status**: Draft  
**Input**: Séptimo módulo de laboratorios y rap sobre Almacenamiento Local (Particiones GPT/MBR y Administración Completa de LVM, incluyendo LVM VDO) para el examen RHCSA EX200 (RHEL 9).

## User Scenarios & Testing

### User Story 1 - Demo y Challenge Práctico (Priority: P1)
El estudiante crea particiones en un disco secundario, inicializa Physical Volumes (PV), crea un Volume Group (VG) y define Logical Volumes (LV). Luego extiende un LV existente redimensionando su sistema de archivos en caliente, y configura un volumen optimizado LVM VDO.

**Acceptance Scenarios**:
1. **Given** un nuevo disco en la VM, **When** el estudiante ejecute la secuencia `pvcreate`, `vgcreate`, `lvcreate` y formatee en XFS, **Then** el volumen lógico debe ser montable y funcional.
2. **Given** un volumen con espacio insuficiente, **When** el estudiante ejecute `lvextend -r -L +1G`, **Then** el sistema de archivos debe extenderse de forma automática y segura en caliente.

## Requirements
- **FR-001**: El laboratorio MUST simular la adición de un disco secundario en la VM de Vagrant.
- **FR-002**: El laboratorio MUST cubrir el flujo completo de creación, extensión y administración de LVM.
- **FR-003**: El laboratorio MUST incluir la creación de volúmenes LVM VDO (`lvcreate --type vdo`).
- **FR-004**: El script `verify.sh` MUST inspeccionar los metadatos de LVM usando `pvs`, `vgs` y `lvs` sin alterar los discos de la VM.
- **FR-005**: La letra de rap técnico en español MUST guardarse en `../RHCSA-EX200-lyrics/07-local-storage.txt`, rimando `pvcreate`, `vgextend`, `lvextend -r` y la sintaxis de LVM VDO.
