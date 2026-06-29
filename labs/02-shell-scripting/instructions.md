# Reto Práctico: Creación de Script en Bash (Módulo 02)

Este reto evalúa tu capacidad para automatizar tareas en Rocky/AlmaLinux 9 utilizando Shell Scripting en Bash.

## Objetivos del Reto

Escribe un script en Bash llamado `file_filter.sh` dentro del directorio `challenge/` (debes crearlo tú mismo) que cumpla exactamente con los siguientes requisitos funcionales:

1. **Control de Parámetros**:
   * El script debe recibir exactamente **dos parámetros** obligatorios:
     * `$1`: Ruta absoluta o relativa a un directorio.
     * `$2`: Extensión de archivo a filtrar (por ejemplo: `txt`, `log`).
   * Si no se proporcionan exactamente 2 parámetros (es decir, el conteo `$#` no es igual a 2), el script debe imprimir un mensaje de error explicativo en el canal de errores (**stderr**) y finalizar inmediatamente con el **código de salida `1`**.

2. **Validación del Directorio**:
   * Si el directorio indicado en el primer parámetro (`$1`) no existe o no es un directorio válido, el script debe imprimir un mensaje de error explicativo en **stderr** y finalizar inmediatamente con el **código de salida `2`**.

3. **Filtrado de Archivos**:
   * El script debe buscar todos los archivos dentro del directorio que coincidan con la extensión proporcionada en `$2`.
   * Para cada archivo encontrado, debe imprimir únicamente su nombre de archivo (usando `basename` para omitir la ruta) en la salida estándar (**stdout**).
   * Si no se encuentra ningún archivo con esa extensión dentro del directorio, debe imprimir un mensaje indicando que no se encontraron archivos (en **stdout**) y finalizar con el **código de salida `3`**.

4. **Éxito**:
   * Si el script procesó y listó los archivos exitosamente, debe finalizar con el **código de salida `0`**.

## Evaluación

Una vez que completes el script y le des permisos de ejecución (`chmod +x challenge/file_filter.sh`), evalúa tu solución ejecutando:

```bash
./verify.sh
```

Puedes ver pistas progresivas en `hints.md` y restablecer el entorno de pruebas con `./reset.sh`.
