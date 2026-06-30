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

# 1. Crear Unidad Timer
clear_section "RHCSA Módulo 14: Systemd Timers - Tema: 1. Crear una Unidad Timer"
run_demo_cmd "Crea servicio de ejemplo" "echo '[Unit]
Description=Test Timer Service
[Service]
Type=oneshot
ExecStart=/bin/echo RHCSA timer test' | sudo tee /etc/systemd/system/rhcsa-timer.service"
run_demo_cmd "Crea timer" "echo '[Unit]
Description=RHCSA Test Timer
[Timer]
OnCalendar=*:0/1
Persistent=true
[Install]
WantedBy=timers.target' | sudo tee /etc/systemd/system/rhcsa-timer.timer"
run_demo_cmd "Habilita timer" "sudo systemctl enable --now rhcsa-timer.timer"
run_demo_cmd "Lista timers" "systemctl list-timers | grep rhcsa || echo 'Verificación'"
sleep 2.0

# 2. Probar Timer
clear_section "RHCSA Módulo 14: Systemd Timers - Tema: 2. Probar el Timer"
run_demo_cmd "Verifica activo" "systemctl is-active rhcsa-timer.timer"
run_demo_cmd "Muestra status" "systemctl status rhcsa-timer.timer | head -5"
sleep 2.0

# 3. Configurar Servicio
clear_section "RHCSA Módulo 14: Systemd Timers - Tema: 3. Configurar Servicio Asociado"
run_demo_cmd "Verifica servicio" "systemctl status rhcsa-timer.service | head -3 || true"
sleep 2.0

# 4. Validar
clear_section "RHCSA Módulo 14: Systemd Timers - Tema: 4. Validar"
run_demo_cmd "Lista timers activos" "systemctl list-timers --all | head -3"
run_demo_cmd "Deshabilita" "sudo systemctl disable --now rhcsa-timer.timer"
rm -f /etc/systemd/system/rhcsa-timer.*
sudo systemctl daemon-reload
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
