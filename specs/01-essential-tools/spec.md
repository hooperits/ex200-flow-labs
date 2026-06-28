# Feature Specification: 01-essential-tools

**Feature Branch**: `01-essential-tools`  
**Created**: 2026-06-28  
**Status**: Draft  
**Input**: Primer módulo de laboratorios y rap sobre Herramientas Esenciales e Inicio de Sesión del examen RHCSA EX200 (RHEL 9).

## User Scenarios & Testing

### User Story 1 - Demostración Interactiva en la VM (Priority: P1)

El estudiante desea ver una demostración visual interactiva sobre el uso de herramientas esenciales de Linux directamente en la terminal de la máquina virtual de Rocky Linux 9.

**Why this priority**: Es el primer paso pedagógico. Permite capturar los comandos en video y muestra al estudiante cómo funciona cada concepto con ejemplos visuales paso a paso antes de que intente resolverlo él mismo.

**Independent Test**: Ejecutar el script `demo.sh` dentro de la VM de Vagrant. Debe imprimir en consola, de forma animada (con colores y pausas), explicaciones en español de los siguientes puntos y ejecutar sus respectivos comandos en inglés:
1. Redirecciones de entrada/salida y pipes.
2. Uso de `grep` y expresiones regulares para buscar texto.
3. Compresión y archivado con `tar`.
4. Creación de enlaces duros y simbólicos.
5. Permisos estándar de archivos (`ugo/rwx`, `chmod`, `chown`).

**Acceptance Scenarios**:
1. **Given** la VM de Vagrant encendida, **When** el estudiante ejecute `/labs/01-essential-tools/demo.sh`, **Then** la terminal debe mostrar animaciones, colores explicativos en español, ejecutar los comandos paso a paso y finalizar con código de salida 0.

---

### User Story 2 - Resolución del Challenge Práctico (Priority: P1)

El estudiante lee las instrucciones del reto y realiza los cambios de configuración necesarios en el sistema de archivos de la VM para resolverlo.

**Why this priority**: Es la práctica directa. La única forma de aprobar el examen EX200 es realizando las tareas de forma manual en la shell.

**Independent Test**: Seguir las instrucciones de `/labs/01-essential-tools/instructions.md` y verificar que el estudiante pueda interactuar con el entorno configurando enlaces, permisos y redirecciones.

**Acceptance Scenarios**:
1. **Given** el laboratorio recién inicializado, **When** el estudiante lea `instructions.md`, **Then** debe encontrar 5 tareas específicas redactadas en español con comandos/conceptos clave en inglés (ej. crear un link simbólico, configurar un archivo con permisos `640` perteneciente a un grupo específico, y guardar el output de un filtro `grep` en un path exacto).

---

### User Story 3 - Evaluación Automatizada (Priority: P1)

El estudiante ejecuta el script evaluador para comprobar si resolvió el reto de forma correcta.

**Why this priority**: Proporciona retroalimentación rápida y objetiva. Simula la revisión del examen real de Red Hat de manera automática.

**Independent Test**: Ejecutar `/labs/01-essential-tools/verify.sh` en la VM después de intentar resolver el reto.

**Acceptance Scenarios**:
1. **Given** que el estudiante no ha realizado el reto, **When** ejecute `verify.sh`, **Then** todos los puntos evaluados deben marcar `FAILED` y el script debe retornar un código de salida distinto de 0.
2. **Given** que el estudiante configuró correctamente los enlaces y permisos del reto, **When** ejecute `verify.sh`, **Then** la salida debe mostrar `PASSED` para cada punto y el script debe retornar un código de salida 0.

---

### User Story 4 - Letra del Rap para Nemotecnia (Priority: P2)

El instructor/estudiante desea tener la letra del rap técnico en español para generar música con Suno y un video con revid.ai.

**Why this priority**: Ayuda a la retención a largo plazo mediante mnemotecnia musical fuera del entorno de programación.

**Independent Test**: Validar que el archivo `/home/juanca/RHCSA-EX200-lyrics/01-essential-tools.txt` contenga las rimas técnicas en español con los comandos y flags del módulo.

**Acceptance Scenarios**:
1. **Given** el desarrollo del módulo, **When** se finalice la especificación, **Then** debe existir la letra del rap en la ruta externa especificada, rimando comandos como `tar -czvf`, `ln -s`, `chmod`, `chown` y `grep -E`.

---

## Requirements

### Functional Requirements

- **FR-001**: El laboratorio MUST contener un script `demo.sh` que demuestre interactivamente:
  - Redirección de stdout (`>`) y stderr (`2>`).
  - Filtrado con `grep` y regex.
  - Archivación con `tar` y compresión `gzip`/`bzip2`.
  - Enlaces duros (`ln`) y blandos (`ln -s`).
  - Permisos standard (`chmod` octal y simbólico, `chown` usuario/grupo).
- **FR-002**: El laboratorio MUST proveer un script `verify.sh` que compruebe analíticamente y sin alterar el sistema:
  - Si el enlace simbólico y el enlace duro solicitados existen y apuntan al origen correcto.
  - Si el archivo del reto tiene exactamente los permisos configurados (ej. `rw-r-----` o `640`) y pertenece al propietario y grupo correctos.
  - Si el archivo de texto resultante del filtro `grep` contiene las líneas esperadas.
- **FR-003**: El laboratorio MUST contener un script `reset.sh` que limpie los directorios y archivos creados para el reto, restaurando el entorno al estado inicial de práctica.
- **FR-004**: Las letras de rap técnico MUST escribirse en español en el archivo `/home/juanca/RHCSA-EX200-lyrics/01-essential-tools.txt` y enfocarse en la memorización de la sintaxis y flags exactos.
- **FR-005**: Todo el contenido explicativo para el usuario MUST estar en español, pero los comandos y conceptos de Linux MUST permanecer en inglés técnico.

### Key Entities

- **Vagrant Environment**: La máquina virtual Rocky Linux 9 donde residen todos los laboratorios interactivos bajo `/labs/`.
- **Lab Directory (`/labs/01-essential-tools/`)**: El directorio en la VM que contiene `demo.sh`, `instructions.md`, `hints.md`, `verify.sh` y `reset.sh`.
- **Lyrics File (`/home/juanca/RHCSA-EX200-lyrics/01-essential-tools.txt`)**: Archivo externo que contiene el guion lírico del módulo.

## Success Criteria

### Measurable Outcomes

- **SC-001**: El script `demo.sh` se ejecuta de forma continua, demostrando todos los temas en menos de 3 minutos.
- **SC-002**: El script `verify.sh` realiza todas las comprobaciones en menos de 5 segundos.
- **SC-003**: El script `reset.sh` devuelve el entorno a su estado original de manera limpia y sin errores de archivos no encontrados.
- **SC-004**: El archivo de letras de rap externo contiene al menos 4 estrofas y 1 coro que incorporan con rima al menos 5 comandos diferentes con sus respectivos flags.

## Assumptions

- Se asume que el usuario tiene instalado Vagrant y habilitado Hyper-V en su host Windows.
- La VM de Rocky Linux 9 tiene acceso a internet básico durante su aprovisionamiento inicial para descargar paquetes adicionales (como `bash-completion`, `tree` o utilidades básicas) pero no requiere internet durante la resolución del reto.
