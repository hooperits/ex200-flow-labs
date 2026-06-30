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

# 1. Inspeccionar Parámetros del Kernel
clear_section "RHCSA Módulo 13: Kernel y sysctl - Tema: 1. Inspeccionar Parámetros del Kernel"
run_demo_cmd "Lista parámetros clave" "sysctl -a | grep -E 'kernel|net.ipv4' | head -5"
run_demo_cmd "Muestra hostname del kernel" "sysctl kernel.hostname"
run_demo_cmd "Lista net params" "sysctl net.ipv4.ip_forward"
sleep 2.0

# 2. Modificar Temporalmente
clear_section "RHCSA Módulo 13: Kernel y sysctl - Tema: 2. Modificar Parámetros Temporalmente"
run_demo_cmd "Cambia hostname temporal" "sudo sysctl -w kernel.hostname=testhost"
run_demo_cmd "Verifica cambio" "sysctl kernel.hostname"
run_demo_cmd "Muestra /proc" "cat /proc/sys/kernel/hostname"
run_demo_cmd "Restaura" "sudo sysctl -w kernel.hostname=localhost"
sleep 2.0

# 3. Hacer Persistente
clear_section "RHCSA Módulo 13: Kernel y sysctl - Tema: 3. Hacer Cambios Persistentes"
run_demo_cmd "Añade a sysctl.d" "echo 'net.ipv4.ip_forward = 1' | sudo tee /etc/sysctl.d/99-test.conf"
run_demo_cmd "Aplica cambios" "sudo sysctl -p /etc/sysctl.d/99-test.conf"
run_demo_cmd "Verifica" "sysctl net.ipv4.ip_forward"
rm -f /etc/sysctl.d/99-test.conf
sudo sysctl -w net.ipv4.ip_forward=0 &>/dev/null || true
sleep 2.0

# 4. Probar y Validar
clear_section "RHCSA Módulo 13: Kernel y sysctl - Tema: 4. Probar sysctl"
run_demo_cmd "Usa sysctl -w para test" "sudo sysctl -w kernel.sysrq=1"
run_demo_cmd "Verifica en /proc" "cat /proc/sys/kernel/sysrq"
sudo sysctl -w kernel.sysrq=0 &>/dev/null || true
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
