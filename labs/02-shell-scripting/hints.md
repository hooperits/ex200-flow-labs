# Pistas del Reto: 02-shell-scripting

## 1. Conteo de Argumentos
* En Bash, puedes comprobar el número de argumentos usando `$#`.
* Recuerda comparar usando operadores numéricos como `-ne` (Not Equal / No igual):
  ```bash
  if [ "$#" -ne 2 ]; then
      echo "Mensaje de error" >&2
      exit 1
  fi
  ```
* Redirigir a stderr se realiza usando `>&2` al final del comando `echo`.

## 2. Validación de Directorio
* Utiliza el condicional `if [ ! -d "$variable" ]` para comprobar si el directorio NO existe:
  ```bash
  if [ ! -d "$1" ]; then
      echo "Mensaje de error de directorio" >&2
      exit 2
  fi
  ```

## 3. Bucle y Filtrado
* Para buscar archivos con la extensión, puedes usar un bucle `for` expandiendo la ruta:
  ```bash
  for file in "$1"/*."$2"; do
      # Tu logica aqui
  done
  ```
* Si el patrón no coincide con nada, Bash por defecto puede conservar el asterisco literal. Para evitarlo, puedes usar `shopt -s nullglob` al principio del script o verificar la existencia de cada archivo individual en el bucle usando `if [ -f "$file" ]`.
* Usa el comando `basename` para extraer solo el nombre del archivo sin la ruta del directorio:
  ```bash
  basename "$file"
  ```
