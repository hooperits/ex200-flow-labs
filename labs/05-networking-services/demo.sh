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

# 1. Configuración de Hostname
clear_section "RHCSA Módulo 05: Redes y Servicios - Tema: 1. Hostname"
run_demo_cmd "Visualizamos la información actual del nombre del host" "hostnamectl status"
run_demo_cmd "Simulamos configurar el hostname permanente del servidor" "echo 'hostnamectl set-hostname server-test' (ejemplo de hostnamectl)"
run_demo_cmd "Leemos el archivo /etc/hosts para la resolución local" "head -n 5 /etc/hosts"
run_demo_cmd "Mostramos la IP asociada al hostname actual" "hostname -I | awk '{print \$1}'"
sleep 2.0

# 2. Configuración de Red con nmcli
clear_section "RHCSA Módulo 05: Redes y Servicios - Tema: 2. Red con nmcli"
run_demo_cmd "Listamos todos los dispositivos de red disponibles" "nmcli device"
run_demo_cmd "Listamos las conexiones de red configuradas" "nmcli connection show"
run_demo_cmd "Simulamos modificar una conexión para asignar IP estática" "echo 'nmcli connection modify eth1 ipv4.addresses 192.168.56.20/24' (ejemplo de nmcli)"
run_demo_cmd "Simulamos reactivar la conexión modificada" "echo 'nmcli connection up eth1' (ejemplo de nmcli)"
sleep 2.0

# 3. Sincronización de Tiempo (chronyd)
clear_section "RHCSA Módulo 05: Redes y Servicios - Tema: 3. NTP con chrony"
run_demo_cmd "Comprobamos el estado del servicio chronyd" "systemctl status chronyd | head -n 4"
run_demo_cmd "Verificamos los servidores de tiempo NTP conectados usando chronyc" "chronyc sources"
run_demo_cmd "Mostramos los parámetros de sincronización del reloj del sistema" "chronyc tracking"
run_demo_cmd "Buscamos los servidores NTP definidos en el archivo de configuración" "grep '^server' /etc/chrony.conf || grep '^pool' /etc/chrony.conf"
sleep 2.0

# 4. Planificación de Tareas (Cron/At)
clear_section "RHCSA Módulo 05: Redes y Servicios - Tema: 4. Tareas con Cron"
run_demo_cmd "Listamos las tareas cron programadas para el usuario actual" "crontab -l 2>/dev/null || echo '(No hay tareas programadas para vagrant)'"
run_demo_cmd "Listamos los archivos de tareas cron del sistema en /etc/cron.d/" "ls -l /etc/cron.d/ | head -n 5"
run_demo_cmd "Mostramos el contenido del archivo crontab del sistema principal" "head -n 12 /etc/crontab"
run_demo_cmd "Simulamos programar una tarea cron usando crontab -e" "echo '0 2 * * * /usr/local/bin/backup.sh' (ejemplo de crontab)"
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
