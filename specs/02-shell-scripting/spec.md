# Feature Specification: 02-shell-scripting

**Feature Branch**: `02-shell-scripting`  
**Created**: 2026-06-28  
**Status**: Draft  
**Input**: Segundo módulo de laboratorios y rap sobre la Creación de Scripts sencillos en Bash para el examen RHCSA EX200 (RHEL 9).

## User Scenarios & Testing

### User Story 1 - Demo y Challenge Práctico (Priority: P1)
El estudiante ejecuta la demostración en la VM y luego implementa un script en Bash siguiendo las instrucciones en español para resolver un problema de automatización.

**Acceptance Scenarios**:
1. **Given** el laboratorio, **When** el estudiante lea `instructions.md`, **Then** debe escribir un script en Bash que acepte argumentos, use un bucle `for` y una estructura condicional `if/then/else` para procesar archivos o directorios.
2. **Given** el script del reto desarrollado por el estudiante, **When** se ejecute `verify.sh`, **Then** debe validar que el script resuelva la lógica esperada, acepte parámetros correctamente y devuelva los códigos de salida apropiados.

## Requirements
- **FR-001**: El laboratorio MUST contener un script `demo.sh` que enseñe condicionales, bucles (`for`/`while`) y manejo de argumentos de script (`$1`, `$2`, etc.) en Bash.
- **FR-002**: El script `verify.sh` MUST validar el script desarrollado por el estudiante pasándole diferentes argumentos de prueba y analizando su salida y código de retorno.
- **FR-003**: La letra de rap técnico en español MUST escribirse en `/home/juanca/RHCSA-EX200-lyrics/02-shell-scripting.txt` rimando conceptos de Bash (`if [ -f $1 ]`, `for item in $list`, etc.).
- **FR-004**: Todo el material interactivo en consola y textos explicativos deben estar en español, conservando los términos de programación de la shell en inglés.
