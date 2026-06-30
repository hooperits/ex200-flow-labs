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
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../lib/demo-common.sh"

# 1. Búsqueda y Descarga de Imágenes
clear_section "RHCSA Módulo 09: Gestión de Contenedores con Podman - Tema: 1. Búsqueda y Descarga de Imágenes de Contenedor"
run_demo_cmd "Buscamos imágenes de nginx en los registros públicos configurados" "podman search registry.access.redhat.com/ubi9/nginx-120 | head -n 4"
run_demo_cmd "Listamos las imágenes descargadas actualmente en el sistema local" "podman images"
run_demo_cmd "Simulamos descargar una imagen ligera de prueba" "echo 'podman pull registry.access.redhat.com/ubi9/nginx-120' (ejemplo de pull)"
run_demo_cmd "Mostramos los detalles y metadatos de una imagen" "echo 'podman inspect registry.access.redhat.com/ubi9/nginx-120' (ejemplo de inspect)"
sleep 2.0

# 2. Ejecución y Control de Contenedores
clear_section "RHCSA Módulo 09: Gestión de Contenedores con Podman - Tema: 2. Creación, Ejecución y Listado de Contenedores"
run_demo_cmd "Listamos todos los contenedores activos" "podman ps"
run_demo_cmd "Listamos todos los contenedores (incluyendo los detenidos)" "podman ps -a"
run_demo_cmd "Simulamos crear y ejecutar un contenedor en segundo plano con puerto y volumen" "echo 'podman run -d --name web-server -p 8080:8080 -v /home/vagrant/html:/var/www/html:Z nginx' (ejemplo de run)"
run_demo_cmd "Simulamos ver los logs en tiempo real de un contenedor" "echo 'podman logs web-server' (ejemplo de logs)"
sleep 2.0

# 3. Contenedores Rootless (Sin Privilegios)
clear_section "RHCSA Módulo 09: Gestión de Contenedores con Podman - Tema: 3. Ejecución Segura en Modo Rootless"
run_demo_cmd "Verificamos que el contenedor se ejecute con nuestro usuario sin usar sudo" "whoami"
run_demo_cmd "Comprobamos el uso de puertos no privilegiados (mayores a 1024) para rootless" "echo 'Mapeando puerto host 8080 hacia el contenedor'"
run_demo_cmd "Mostramos la información de namespaces de usuario activos en la VM" "cat /proc/self/uid_map"
run_demo_cmd "Simulamos inspeccionar el estado de los procesos internos del contenedor" "echo 'podman top web-server' (ejemplo de top)"
sleep 2.0

# 4. Integración con systemd de Usuario y Linger
clear_section "RHCSA Módulo 09: Gestión de Contenedores con Podman - Tema: 4. Automatización con systemd de Usuario y Linger"
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
