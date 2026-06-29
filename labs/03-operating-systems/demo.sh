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
    
    # Filtrar comentarios explicativos entre paréntesis para evitar errores de sintaxis en eval
    local exec_cmd
    exec_cmd=$(echo "$cmd" | sed 's/ ([^)]*)$//')
    eval "$exec_cmd"
    echo
    sleep 5.0
}

# Helper to clean terminal and show section header
clear_section() {
    clear
    echo -e "${CYAN}================================================================${NC}"
    echo -e "${CYAN}    RHCSA Módulo 03: Operación del Sistema en Ejecución         ${NC}"
    echo -e "${CYAN}    Tema: $1${NC}"
    echo -e "${CYAN}================================================================${NC}"
    echo
    sleep 2.0
}

# 1. systemctl para servicios
clear_section "1. Control de Servicios con systemctl"
run_demo_cmd "Comprobamos el estado del servicio sshd" "systemctl status sshd | head -n 5"
run_demo_cmd "Verificamos si un servicio está habilitado para el arranque" "systemctl is-enabled sshd"
run_demo_cmd "Verificamos si un servicio está actualmente activo" "systemctl is-active sshd"
run_demo_cmd "Listamos todos los servicios cargados en el sistema" "systemctl list-units --type=service --state=running | head -n 6"
sleep 2.0

# 2. Control de Targets
clear_section "2. Gestión de Entornos de Arranque (Targets)"
run_demo_cmd "Obtenemos el target predeterminado del sistema" "systemctl get-default"
run_demo_cmd "Listamos los targets disponibles actualmente" "systemctl list-units --type=target | head -n 6"
run_demo_cmd "Simulamos cómo cambiar el target a modo consola (multi-user.target)" "echo 'systemctl set-default multi-user.target' (comando de demostración)"
run_demo_cmd "Simulamos cómo cambiar el target a modo gráfico (graphical.target)" "echo 'systemctl set-default graphical.target' (comando de demostración)"
sleep 2.0

# 3. Gestión de Procesos
clear_section "3. Monitoreo y Modificación de Procesos"
run_demo_cmd "Listamos procesos ordenados por consumo de recursos" "ps aux --sort=-%cpu | head -n 5"
run_demo_cmd "Buscamos un proceso específico por su nombre usando pgrep" "pgrep -l systemd | head -n 4"
run_demo_cmd "Mostramos la prioridad 'nice' de los procesos en ejecución" "ps -el | head -n 5"
run_demo_cmd "Simulamos cómo cambiar la prioridad de un proceso con renice" "echo 'renice -n 5 -p 1234' (ejemplo de renice)"
sleep 2.0

# 4. Lectura de Logs con journalctl
clear_section "4. Inspección de Logs con journalctl"
run_demo_cmd "Mostramos las últimas 5 líneas del log del sistema" "journalctl -n 5"
run_demo_cmd "Filtramos los logs de un servicio específico como sshd" "journalctl -u sshd -n 4"
run_demo_cmd "Filtramos los logs mostrando únicamente errores importantes con '-p err'" "journalctl -p err -n 4 --no-pager"
run_demo_cmd "Mostramos los logs generados desde el arranque actual usando '-b'" "journalctl -b -n 4 --no-pager"
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
