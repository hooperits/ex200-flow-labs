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
    local delay="${2:-0.03}"
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
    sleep 1.0
    echo -n -e "${BLUE}vagrant@localhost:~$ ${NC}"
    type_text "$cmd" 0.03
    sleep 0.8
    eval "$cmd"
    echo
    sleep 5.0
}

# Helper to clean terminal and show section header
clear_section() {
    clear
    echo -e "${CYAN}================================================================${NC}"
    echo -e "${CYAN}    RHCSA Módulo 04: Gestión de Usuarios, Grupos y Permisos     ${NC}"
    echo -e "${CYAN}    Tema: $1${NC}"
    echo -e "${CYAN}================================================================${NC}"
    echo
    sleep 2.0
}

# 1. Creación y Modificación de Usuarios
clear_section "1. Administración de Usuarios"
run_demo_cmd "Buscamos información de nuestro usuario actual en /etc/passwd" "grep '^vagrant' /etc/passwd"
run_demo_cmd "Simulamos la creación de un usuario con ID y Shell específicos" "echo 'useradd -u 2001 -s /sbin/nologin user_test' (ejemplo de creación)"
run_demo_cmd "Simulamos modificar la pertenencia a grupos secundarios de un usuario" "echo 'usermod -aG wheel user_test' (ejemplo de usermod)"
run_demo_cmd "Mostramos la información de expiración de contraseña de un usuario con chage" "sudo chage -l vagrant | head -n 5"
sleep 2.0

# 2. Administración de Grupos
clear_section "2. Administración de Grupos"
run_demo_cmd "Listamos algunos grupos definidos en el sistema" "tail -n 5 /etc/group"
run_demo_cmd "Simulamos crear un nuevo grupo de trabajo" "echo 'groupadd sysadmins' (ejemplo de groupadd)"
run_demo_cmd "Verificamos los grupos a los que pertenece el usuario actual" "groups"
run_demo_cmd "Mostramos la pertenencia de un usuario con el comando id" "id vagrant"
sleep 2.0

# 3. Permisos Especiales (SGID, Sticky Bit)
clear_section "3. Permisos Especiales (SGID y Sticky Bit)"
run_demo_cmd "Creamos un directorio temporal para pruebas de permisos" "mkdir -p docs_temp"
run_demo_cmd "Asignamos el bit SGID al directorio (los archivos heredan el grupo)" "chmod g+s docs_temp"
run_demo_cmd "Mostramos los permisos del directorio para visualizar la 's' de SGID" "ls -ld docs_temp"
run_demo_cmd "Asignamos el Sticky Bit a un directorio (solo el dueño borra sus archivos)" "chmod +t docs_temp"
run_demo_cmd "Visualizamos la 't' del Sticky Bit en los permisos de otros" "ls -ld docs_temp"
rm -rf docs_temp
sleep 2.0

# 4. Listas de Control de Acceso (ACLs)
clear_section "4. Control de Acceso Fino (ACLs)"
run_demo_cmd "Creamos un archivo temporal para pruebas de ACLs" "touch notas_acl.txt"
run_demo_cmd "Leemos las ACLs por defecto del archivo usando getfacl" "getfacl notas_acl.txt"
run_demo_cmd "Asignamos un permiso de lectura específico a un usuario ficticio con setfacl" "setfacl -m u:nobody:r notas_acl.txt"
run_demo_cmd "Comprobamos el cambio en las ACLs y vemos el signo '+' en los permisos" "getfacl notas_acl.txt"
run_demo_cmd "Eliminamos todas las ACLs asignadas al archivo" "setfacl -b notas_acl.txt"
rm -f notas_acl.txt
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
