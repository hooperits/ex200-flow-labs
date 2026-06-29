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
    echo -e "${CYAN}    RHCSA Módulo 09: Gestión de Contenedores con Podman         ${NC}"
    echo -e "${CYAN}    Tema: $1${NC}"
    echo -e "${CYAN}================================================================${NC}"
    echo
    sleep 2.0
}

# 1. Búsqueda y Descarga de Imágenes
clear_section "1. Búsqueda y Descarga de Imágenes de Contenedor"
run_demo_cmd "Buscamos imágenes de nginx en los registros públicos configurados" "podman search registry.access.redhat.com/ubi9/nginx-120 | head -n 4"
run_demo_cmd "Listamos las imágenes descargadas actualmente en el sistema local" "podman images"
run_demo_cmd "Simulamos descargar una imagen ligera de prueba" "echo 'podman pull registry.access.redhat.com/ubi9/nginx-120' (ejemplo de pull)"
run_demo_cmd "Mostramos los detalles y metadatos de una imagen" "echo 'podman inspect registry.access.redhat.com/ubi9/nginx-120' (ejemplo de inspect)"
sleep 2.0

# 2. Ejecución y Control de Contenedores
clear_section "2. Creación, Ejecución y Listado de Contenedores"
run_demo_cmd "Listamos todos los contenedores activos" "podman ps"
run_demo_cmd "Listamos todos los contenedores (incluyendo los detenidos)" "podman ps -a"
run_demo_cmd "Simulamos crear y ejecutar un contenedor en segundo plano con puerto y volumen" "echo 'podman run -d --name web-server -p 8080:8080 -v /home/vagrant/html:/var/www/html:Z nginx' (ejemplo de run)"
run_demo_cmd "Simulamos ver los logs en tiempo real de un contenedor" "echo 'podman logs web-server' (ejemplo de logs)"
sleep 2.0

# 3. Contenedores Rootless (Sin Privilegios)
clear_section "3. Ejecución Segura en Modo Rootless"
run_demo_cmd "Verificamos que el contenedor se ejecute con nuestro usuario sin usar sudo" "whoami"
run_demo_cmd "Comprobamos el uso de puertos no privilegiados (mayores a 1024) para rootless" "echo 'Mapeando puerto host 8080 hacia el contenedor'"
run_demo_cmd "Mostramos la información de namespaces de usuario activos en la VM" "cat /proc/self/uid_map"
run_demo_cmd "Simulamos inspeccionar el estado de los procesos internos del contenedor" "echo 'podman top web-server' (ejemplo de top)"
sleep 2.0

# 4. Integración con systemd de Usuario y Linger
clear_section "4. Automatización con systemd de Usuario y Linger"
run_demo_cmd "Simulamos generar el archivo de unidad systemd para el contenedor" "echo 'podman generate systemd --new --files --name web-server' (ejemplo de generate)"
run_demo_cmd "Listamos las unidades de servicios del usuario actual" "ls -l ~/.config/systemd/user/ 2>/dev/null || echo '(Directorio no creado aún)'"
run_demo_cmd "Simulamos habilitar el servicio de usuario de systemd" "echo 'systemctl --user enable container-web-server.service' (ejemplo de enable)"
run_demo_cmd "Simulamos habilitar persistencia de sesión sin login (linger)" "echo 'loginctl enable-linger vagrant' (ejemplo de linger)"
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
