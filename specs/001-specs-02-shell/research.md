# Research Notes: 02-shell-scripting

Analysis of Bash scripting logic for RHEL 9 VM.

## Argument count checks
In Bash, `$#` contains the number of arguments passed to the script. We can assert arguments using:
```bash
if [ "$#" -ne 2 ]; then
    echo "Error: Se requieren exactamente 2 argumentos." >&2
    exit 1
fi
```

## Directory checks
Use `[ ! -d "$1" ]` to verify if a path exists and is a directory:
```bash
if [ ! -d "$1" ]; then
    echo "Error: El directorio '$1' no existe." >&2
    exit 2
fi
```

## Wildcard expansion and loops
When looping over wildcards (e.g. `"$1"/*."$2"`), if no files match the wildcard, Bash will literally return the string containing the wildcard (e.g. `/path/*.txt`). We can prevent this by setting `shopt -s nullglob` or checking if the file exists:
```bash
shopt -s nullglob
files=("$1"/*."$2")
if [ ${#files[@]} -eq 0 ]; then
    echo "No se encontraron archivos."
    exit 3
fi
```
This is robust and standard for RHEL 9 systems.
