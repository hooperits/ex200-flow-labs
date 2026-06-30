#!/bin/bash

# ANSI colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Cargar helpers comunes (soporte --video / --fast)
source "/labs/lib/demo-common.sh"

# 1. Redirecciones de entrada/salida y pipes
clear_section "RHCSA Módulo 01: Herramientas Esenciales - Tema: 1. Redirecciones y Pipes"
run_demo_cmd "Redirigimos la salida estándar (stdout) a un archivo usando el operador '>'" "echo 'Hola Estudiante EX200' > saludo.txt"
run_demo_cmd "Leemos el archivo creado para confirmar su contenido" "cat saludo.txt"
run_demo_cmd "Redirigimos el canal de error (stderr, descriptor 2) a otro archivo usando '2>'" "ls archivo_inexistente.txt 2> error.log"
run_demo_cmd "Leemos el archivo de errores" "cat error.log"
run_demo_cmd "Usamos un pipe '|' para enviar la salida de un comando como entrada de otro" "echo -e 'rojo\nverde\nazul\namarillo' | grep 'a'"
rm -f saludo.txt error.log
sleep 2.0

# 2. Uso de grep y expresiones regulares
clear_section "RHCSA Módulo 01: Herramientas Esenciales - Tema: 2. Filtrado con grep"
run_demo_cmd "Creamos un archivo temporal con varios registros de prueba" "echo -e 'EX200: Permisos\nEX200: Redes\nOTRO: Linux\nEX200: Storage' > temas.txt"
run_demo_cmd "Usamos grep con expresión regular '^EX200:' para buscar líneas que inicien con ese texto" "grep -E '^EX200:' temas.txt"
rm -f temas.txt
sleep 2.0

# 3. Enlaces duros y simbólicos + Archivación y Compresión con tar (agrupado para alineación con letras)
clear_section "RHCSA Módulo 01: Herramientas Esenciales - Tema: 3. Enlaces y tar"
run_demo_cmd "Creamos un archivo base de origen" "echo 'Datos Importantes' > original.txt"
run_demo_cmd "Creamos un enlace duro que compartirá el mismo inodo que el archivo original" "ln original.txt enlace_duro.txt"
run_demo_cmd "Creamos un enlace simbólico (o de tipo soft) usando la opción '-s'" "ln -s original.txt enlace_simbolico.txt"
run_demo_cmd "Listamos los archivos mostrando el número de inodo ('-i') para comparar" "ls -li original.txt enlace_duro.txt enlace_simbolico.txt"
rm -f original.txt enlace_duro.txt enlace_simbolico.txt
run_demo_cmd "Creamos dos archivos de texto temporales" "touch archivo_a.txt archivo_b.txt"
run_demo_cmd "Creamos un archivo empaquetado y comprimido en formato gzip con 'tar -czvf'" "tar -czvf backup.tar.gz archivo_a.txt archivo_b.txt"
run_demo_cmd "Listamos el contenido del archivo comprimido sin extraerlo usando '-tzf'" "tar -tzf backup.tar.gz"
rm -f archivo_a.txt archivo_b.txt backup.tar.gz
sleep 2.0

# 4. Permisos estándar de archivos (alineado con estructura de letras)
clear_section "RHCSA Módulo 01: Herramientas Esenciales - Tema: 4. Permisos (chmod/chown)"
run_demo_cmd "Creamos un archivo para pruebas de permisos" "touch secreto.txt"
run_demo_cmd "Revisamos los permisos iniciales con ls -l" "ls -l secreto.txt"
run_demo_cmd "Modificamos los permisos a 640 (lectura/escritura dueño, lectura grupo, nada para otros)" "chmod 640 secreto.txt"
run_demo_cmd "Validamos el cambio en la lista de permisos" "ls -l secreto.txt"
run_demo_cmd "Cambiamos el grupo propietario del archivo secreto a 'vagrant'" "chown :vagrant secreto.txt"
run_demo_cmd "Verificamos los propietarios y grupos finales" "ls -l secreto.txt"
rm -f secreto.txt
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0

