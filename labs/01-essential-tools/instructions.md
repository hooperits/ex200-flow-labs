# Reto Práctico: Herramientas Esenciales del Examen EX200

Este reto evaluará tu capacidad para utilizar comandos básicos de manipulación de archivos, filtros, enlaces y permisos en AlmaLinux 10 / RHEL 10.

## Objetivos del Reto

Navega al directorio `/labs/01-essential-tools/` y realiza las siguientes tareas en el subdirectorio `challenge/`:

1. **Creación de Enlaces**:
   * Crea un **enlace simbólico (soft link)** llamado `soft_link_ref` que apunte al archivo `original_data.txt`.
   * Crea un **enlace duro (hard link)** llamado `hard_link_ref` que apunte al archivo `original_data.txt`.

2. **Permisos y Propietarios**:
   * Crea un archivo vacío llamado `secure_perm.txt` dentro de `challenge/`.
   * Configura sus permisos para que sean exactamente `640` (`rw-r-----`), es decir: lectura/escritura para el dueño, lectura para el grupo y ningún permiso para otros.
   * Modifica el grupo propietario del archivo `secure_perm.txt` para que pertenezca al grupo `vagrant`.

3. **Filtrado con grep**:
   * Realiza una búsqueda mediante `grep` en el archivo `original_data.txt` para extraer todas las líneas que comiencen exactamente con el patrón `EX200:` (respetando mayúsculas y minúsculas).
   * Redirige el resultado de la salida estándar (stdout) para guardarlo en un archivo llamado `grep_result.txt` dentro de `challenge/`.

## Evaluación

Una vez completadas todas las tareas, ejecuta el validador automatizado dentro del directorio del laboratorio:

```bash
./verify.sh
```

El script te dará un reporte en tiempo real de qué puntos han pasado y cuáles han fallado. Si algo sale mal, puedes usar las pistas en `hints.md` o reiniciar la práctica con `./reset.sh`.

