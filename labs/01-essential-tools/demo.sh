#!/bin/bash

# ANSI colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Helper for simulated typing
type_text() {
    local text="$1"
    local delay="${2:-0.01}"
    for ((i=0; i<${#text}; i++)); do
        echo -n -e "${text:$i:1}"
        sleep "$delay"
    done
    echo
}

# Helper to show a command being typed and then execute it
run_demo_cmd() {
    local cmd="$2"
    echo -e "${MAGENTA}➔ Explicación:${NC} ${YELLOW}$1${NC}"
    echo -n -e "${BLUE}vagrant@rocky9:~$ ${NC}"
    type_text "$cmd" 0.02
    sleep 0.5
    eval "$cmd"
    echo
    sleep 1.5
}

clear
echo -e "${CYAN}================================================================${NC}"
echo -e "${CYAN}    RHCSA Módulo 01: Demostración de Herramientas Esenciales    ${NC}"
echo -e "${CYAN}================================================================${NC}"
echo

# 1. Redirecciones de entrada/salida y pipes
echo -e "${CYAN}=== 1. Redirecciones de Salida (stdout/stderr) y Pipes ===${NC}"
run_demo_cmd "Redirigimos la salida estándar (stdout) a un archivo usando el operador '>'" "echo 'Hola Estudiante EX200' > saludo.txt"
run_demo_cmd "Leemos el archivo creado" "cat saludo.txt"
run_demo_cmd "Redirigimos el canal de error (stderr, descriptor 2) a otro archivo usando '2>'" "ls archivo_inexistente.txt 2> error.log"
run_demo_cmd "Leemos el archivo de errores" "cat error.log"
run_demo_cmd "Usamos un pipe '|' para enviar la salida de un comando como entrada de otro" "echo -e 'rojo\nverde\nazul\namarillo' | grep 'a'"
rm -f saludo.txt error.log
echo

# 2. Uso de grep y expresiones regulares
echo -e "${CYAN}=== 2. Filtrado con grep y Expresiones Regulares ===${NC}"
run_demo_cmd "Creamos un archivo temporal con varios registros" "echo -e 'EX200: Permisos\nEX200: Redes\nOTRO: Linux\nEX200: Storage' > temas.txt"
run_demo_cmd "Usamos grep con expresión regular '^EX200:' para buscar líneas que inicien con ese texto" "grep -E '^EX200:' temas.txt"
rm -f temas.txt
echo

# 3. Compresión y archivado con tar
echo -e "${CYAN}=== 3. Archivación y Compresión con tar (tar.gz) ===${NC}"
run_demo_cmd "Creamos dos archivos de texto temporales" "touch archivo_a.txt archivo_b.txt"
run_demo_cmd "Creamos un archivo empaquetado y comprimido en formato gzip con 'tar -czvf'" "tar -czvf backup.tar.gz archivo_a.txt archivo_b.txt"
run_demo_cmd "Listamos el contenido del archivo comprimido sin extraerlo" "tar -tzf backup.tar.gz"
rm -f archivo_a.txt archivo_b.txt backup.tar.gz
echo

# 4. Enlaces duros y simbólicos
echo -e "${CYAN}=== 4. Enlaces Duros (Hard Links) y Simbólicos (Soft Links) ===${NC}"
run_demo_cmd "Creamos un archivo base de origen" "echo 'Datos Importantes' > original.txt"
run_demo_cmd "Creamos un enlace duro que compartirá el mismo inodo que el archivo original" "ln original.txt enlace_duro.txt"
run_demo_cmd "Creamos un enlace simbólico (o de tipo soft) usando la opción '-s'" "ln -s original.txt enlace_simbolico.txt"
run_demo_cmd "Listamos los archivos mostrando el número de inodo ('-i') para comparar" "ls -li original.txt enlace_duro.txt enlace_simbolico.txt"
rm -f original.txt enlace_duro.txt enlace_simbolico.txt
echo

# 5. Permisos estándar de archivos
echo -e "${CYAN}=== 5. Permisos de Archivos (chmod / chown) ===${NC}"
run_demo_cmd "Creamos un archivo para pruebas de permisos" "touch secreto.txt"
run_demo_cmd "Revisamos los permisos iniciales con ls -l" "ls -l secreto.txt"
run_demo_cmd "Modificamos los permisos a 640 (lectura/escritura dueño, lectura grupo, nada para otros)" "chmod 640 secreto.txt"
run_demo_cmd "Validamos el cambio en la lista de permisos" "ls -l secreto.txt"
run_demo_cmd "Cambiamos el grupo propietario del archivo secreto a 'vagrant'" "chown :vagrant secreto.txt"
run_demo_cmd "Verificamos los propietarios y grupos finales" "ls -l secreto.txt"
rm -f secreto.txt
echo

echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
