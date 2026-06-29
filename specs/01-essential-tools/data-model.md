# Data Model: 01-essential-tools

Este documento define la estructura de archivos, directorios y validaciones de estado requeridas para el laboratorio de herramientas esenciales.

## Estructura de Entidades del Laboratorio

Todas las entidades residen dentro del directorio del reto: `/labs/01-essential-tools/challenge/` en el guest VM.

### 1. Archivo de Datos de Origen (`original_data.txt`)
* **Propósito**: Semilla de texto con múltiples registros estructurados que sirve para practicar filtros de texto y creación de enlaces.
* **Metadatos**:
  * Tipo: Archivo regular.
  * Contenido estático con líneas que contienen patrones clave como `EX200:`, `SISTEMA:`, y `OTRO:`.

### 2. Enlace Simbólico (`soft_link_ref`)
* **Propósito**: Validar la creación de accesos directos (enlaces blandos).
* **Metadatos**:
  * Tipo: Enlace simbólico (`LNK`).
  * Destino: Debe apuntar directamente a `original_data.txt`.

### 3. Enlace Duro (`hard_link_ref`)
* **Propósito**: Validar el uso de inodos compartidos para protección de datos.
* **Metadatos**:
  * Tipo: Archivo regular.
  * Inodo: Idéntico al inodo de `original_data.txt`.

### 4. Archivo con Permisos Restringidos (`secure_perm.txt`)
* **Propósito**: Validar la modificación octal de accesos y la gestión de grupos.
* **Metadatos**:
  * Tipo: Archivo regular vacío.
  * Permisos: `640` (octal), equivalente a `rw-r-----`.
  * Grupo Propietario: `vagrant`.

### 5. Resultado del Filtro (`grep_result.txt`)
* **Propósito**: Validar redirecciones de flujo de salida (`>`) y filtrado con expresiones regulares.
* **Metadatos**:
  * Tipo: Archivo regular.
  * Contenido: Líneas extraídas de `original_data.txt` que comiencen con el patrón `EX200:`.

## Entidades Externas

* **Metadatos**:
