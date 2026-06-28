# Feature Specification: 05-networking-services

**Feature Branch**: `05-networking-services`  
**Created**: 2026-06-28  
**Status**: Draft  
**Input**: Quinto módulo de laboratorios y rap sobre Configuración de Red (nmcli), hostname, sincronización NTP (chronyd) y planificación de tareas (cron/at) para el examen RHCSA EX200 (RHEL 9).

## User Scenarios & Testing

### User Story 1 - Demo y Challenge Práctico (Priority: P1)
El estudiante configura una dirección IP estática en una interfaz de red secundaria, establece la resolución local de nombres de host, sincroniza la hora con un servidor NTP específico y programa una tarea recurrente con cron.

**Acceptance Scenarios**:
1. **Given** el reto de red, **When** el estudiante configure la conexión usando `nmcli con mod` y active el enlace, **Then** la interfaz de red secundaria debe tener los valores correctos de IP, gateway y DNS.
2. **Given** la verificación, **When** se ejecute `verify.sh`, **Then** debe validar el hostname en `/etc/hostname`, el archivo `/etc/chrony.conf` y las entradas del crontab del usuario.

## Requirements
- **FR-001**: El laboratorio MUST contener demo y retos de comandos `nmcli connection modify` y `nmcli connection up`.
- **FR-002**: El laboratorio MUST cubrir la configuración de un servidor NTP en `/etc/chrony.conf` y la verificación con `chronyc sources`.
- **FR-003**: El script `verify.sh` MUST inspeccionar el estado de red y las tareas programadas sin alterar las configuraciones.
- **FR-004**: La letra de rap técnico en español MUST guardarse en `../RHCSA-EX200-lyrics/05-networking-services.txt`, rimando la sintaxis de `nmcli`, `hostnamectl` y las estrellas del formato `cron` (`* * * * *`).
