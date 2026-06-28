# Pistas y Ayudas del Reto: 01-essential-tools

Si te encuentras atascado en alguna parte del reto, utiliza estas pistas ordenadas por tareas:

## 1. Creación de Enlaces
* **Enlace Simbólico**: Recuerda utilizar la opción `-s` de `ln`. La sintaxis básica es:
  ```bash
  ln -s archivo_origen enlace_destino
  ```
* **Enlace Duro**: Los enlaces duros se crean simplemente omitiendo la opción `-s`:
  ```bash
  ln archivo_origen enlace_destino
  ```
* **Validación**: Puedes comprobar si comparten el mismo inodo usando `ls -li`. Los números a la izquierda de `original_data.txt` y `hard_link_ref` deben ser idénticos.

## 2. Permisos y Propietarios
* **Crear Archivo Vacío**: La forma más rápida de crear un archivo nuevo vacío es con `touch secure_perm.txt`.
* **Permisos Octales**: Para configurar permisos específicos de forma numérica, usa `chmod`:
  ```bash
  chmod 640 secure_perm.txt
  ```
* **Grupo Propietario**: Para cambiar el propietario del grupo sin alterar el dueño del archivo, usa `chown` anteponiendo dos puntos `:` al nombre del grupo:
  ```bash
  chown :vagrant secure_perm.txt
  ```

## 3. Filtrado con grep y Redirecciones
* **Expresión Regular**: Para indicar que un patrón debe estar al inicio de la línea, usa el ancla `^` dentro de `grep`:
  ```bash
  grep '^EX200:' original_data.txt
  ```
* **Redirección**: Para escribir el resultado de un comando en un archivo nuevo (reemplazando su contenido si existe), usa el operador `>`:
  ```bash
  comando > grep_result.txt
  ```
