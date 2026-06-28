# Feature Specification: 09-podman-containers

**Feature Branch**: `09-podman-containers`  
**Created**: 2026-06-28  
**Status**: Draft  
**Input**: Noveno módulo de laboratorios y rap sobre la Gestión de Contenedores con Podman (descarga de imágenes, ejecución rootless, almacenamiento persistente, y automatización con Systemd) para el examen RHCSA EX200 (RHEL 9).

## User Scenarios & Testing

### User Story 1 - Demo y Challenge Práctico (Priority: P1)
El estudiante inicia sesión en la VM como un usuario regular, descarga una imagen (ej. Nginx o MariaDB) de un registro público, ejecuta el contenedor en modo rootless mapeando un puerto y un volumen persistente del host, y finalmente configura systemd para que inicie el contenedor automáticamente al arrancar la VM sin requerir inicio de sesión del usuario.

**Acceptance Scenarios**:
1. **Given** un contenedor ejecutándose en modo rootless, **When** el estudiante ejecute `podman generate systemd --new --files --name <container_name>` en el directorio `~/.config/systemd/user/` y active el servicio con `systemctl --user enable`, **Then** el contenedor debe arrancar automáticamente al iniciar el sistema (requiere habilitar `loginctl enable-linger`).
2. **Given** la verificación, **When** se ejecute `verify.sh`, **Then** debe validar que el servicio de systemd de usuario esté activo, que el contenedor exponga el puerto correcto y que persista los datos en el volumen especificado.

## Requirements
- **FR-001**: El laboratorio MUST guiar al estudiante en la ejecución de contenedores sin privilegios de root (rootless).
- **FR-002**: El laboratorio MUST requerir la persistencia de datos montando directorios de la máquina host del usuario en el contenedor.
- **FR-003**: El laboratorio MUST cubrir la automatización del arranque del contenedor usando servicios de systemd de usuario (`systemctl --user`) y la activación de `loginctl enable-linger`.
- **FR-004**: El script `verify.sh` MUST validar el estado del contenedor y del servicio de systemd del usuario de forma no destructiva.
- **FR-005**: La letra de rap técnico en español MUST guardarse en `/home/juanca/RHCSA-EX200-lyrics/09-podman-containers.txt`, rimando comandos como `podman run -d`, `podman generate systemd` y `loginctl enable-linger`.
