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

# 1. Diagnosticar Servicio
clear_section "RHCSA Módulo 15: Troubleshooting - Tema: 1. Diagnosticar Servicio Fallido"
run_demo_cmd "Simula servicio fallido" "echo 'Simulando servicio roto' "
run_demo_cmd "Usa journalctl para diagnosticar" "journalctl -u sshd --no-pager | tail -5 || true"
run_demo_cmd "Status servicio" "systemctl status sshd | head -5"
sleep 2.0

# 2. Resolver Permisos
clear_section "RHCSA Módulo 15: Troubleshooting - Tema: 2. Resolver Permisos"
run_demo_cmd "Crea archivo con mal permiso" "touch /tmp/broken_perm.txt && chmod 000 /tmp/broken_perm.txt"
run_demo_cmd "Diagnostica" "ls -l /tmp/broken_perm.txt"
run_demo_cmd "Arregla" "chmod 644 /tmp/broken_perm.txt"
run_demo_cmd "Verifica" "ls -l /tmp/broken_perm.txt"
rm -f /tmp/broken_perm.txt
sleep 2.0

# 3. Network Troubleshooting
clear_section "RHCSA Módulo 15: Troubleshooting - Tema: 3. Network Troubleshooting"
run_demo_cmd "Muestra IP" "ip addr show | head -5"
run_demo_cmd "Prueba conectividad" "ping -c 1 127.0.0.1 || true"
run_demo_cmd "Puertos" "ss -tuln | head -3"
sleep 2.0

# 4. Validar
clear_section "RHCSA Módulo 15: Troubleshooting - Tema: 4. Validar y Documentar"
run_demo_cmd "Genera log de diagnóstico" "echo 'Diagnóstico completado' > /tmp/troubleshoot.log"
run_demo_cmd "Verifica" "cat /tmp/troubleshoot.log"
rm -f /tmp/troubleshoot.log
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
