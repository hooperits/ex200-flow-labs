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

# 1. Configuración de Firewalld
clear_section "RHCSA Módulo 06: Seguridad y SELinux - Tema: 1. Firewall (firewalld)"
run_demo_cmd "Listamos el estado de las reglas activas del firewall" "sudo firewall-cmd --list-all | head -n 8"
run_demo_cmd "Obtenemos la zona por defecto asignada actualmente" "sudo firewall-cmd --get-default-zone"
run_demo_cmd "Simulamos añadir el servicio http de forma permanente" "echo 'firewall-cmd --permanent --add-service=http' (ejemplo de firewall-cmd)"
run_demo_cmd "Simulamos aplicar los cambios en caliente usando reload" "echo 'firewall-cmd --reload' (ejemplo de reload)"
sleep 2.0

# 2. Modos y Estados de SELinux
clear_section "RHCSA Módulo 06: Seguridad y SELinux - Tema: 2. Modos de SELinux"
run_demo_cmd "Verificamos si SELinux está activo y en qué modo" "getenforce"
run_demo_cmd "Mostramos los parámetros detallados de estado de SELinux" "sestatus | head -n 6"
run_demo_cmd "Visualizamos los contextos de seguridad de archivos en /etc" "ls -dZ /etc | head -n 4"
run_demo_cmd "Simulamos cambiar el modo activo temporalmente a Permissive" "echo 'setenforce 0' (ejemplo de setenforce)"
sleep 2.0

# 3. Contextos de SELinux (Archivos y Puertos)
clear_section "RHCSA Módulo 06: Seguridad y SELinux - Tema: 3. Contextos SELinux"
run_demo_cmd "Visualizamos los contextos del directorio raíz actual" "ls -lZ / | head -n 6"
run_demo_cmd "Simulamos registrar una regla de contexto de seguridad para Apache" "echo 'semanage fcontext -a -t httpd_sys_content_t \"/var/www/html(/.*)?\"' (ejemplo de fcontext)"
run_demo_cmd "Simulamos forzar la reescritura del contexto del archivo" "echo 'restorecon -R -v /var/www/html' (ejemplo de restorecon)"
run_demo_cmd "Simulamos habilitar un puerto no estándar en SELinux" "echo 'semanage port -a -t http_port_t -p tcp 82' (ejemplo de semanage port)"
sleep 2.0

# 4. Booleanos de SELinux
clear_section "RHCSA Módulo 06: Seguridad y SELinux - Tema: 4. Booleanos SELinux"
run_demo_cmd "Buscamos algunos booleanos relacionados con servicios web" "getsebool -a | grep httpd | head -n 4"
run_demo_cmd "Mostramos el estado actual de un booleano en particular" "getsebool httpd_enable_homedirs"
run_demo_cmd "Simulamos cambiar el valor de un booleano de forma permanente con -P" "echo 'setsebool -P httpd_enable_homedirs on' (ejemplo de setsebool)"
run_demo_cmd "Comprobamos el comando de listado detallado de booleanos" "semanage boolean -l | grep httpd_enable_homedirs | head -n 1"
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
