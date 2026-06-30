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

# 1. Inspeccionar Logs con journalctl
clear_section "RHCSA Módulo 11: Logging Avanzado - Tema: 1. Inspeccionar Logs con journalctl"
run_demo_cmd "Mostramos logs recientes" "journalctl -n 5 --no-pager"
run_demo_cmd "Filtramos por servicio sshd" "journalctl -u sshd -n 3 --no-pager"
run_demo_cmd "Filtramos errores" "journalctl -p err -n 3 --no-pager"
run_demo_cmd "Logs desde boot actual" "journalctl -b -n 3 --no-pager"
sleep 2.0

# 2. Configurar Persistencia
clear_section "RHCSA Módulo 11: Logging Avanzado - Tema: 2. Configurar Persistencia de Logs"
run_demo_cmd "Creamos dir journal si necesario" "sudo mkdir -p /var/log/journal"
run_demo_cmd "Configuramos journald persistente" "sudo sed -i 's/#Storage=.*/Storage=persistent/' /etc/systemd/journald.conf || echo 'Edit manual si necesario'"
run_demo_cmd "Reiniciamos journald" "sudo systemctl restart systemd-journald"
run_demo_cmd "Verificamos persistencia" "ls /var/log/journal/ || echo 'Verificación'"
sleep 2.0

# 3. Configurar rsyslog
clear_section "RHCSA Módulo 11: Logging Avanzado - Tema: 3. Configurar rsyslog"
run_demo_cmd "Añadimos regla rsyslog para test" "echo 'local0.* /var/log/rhcsa-test.log' | sudo tee -a /etc/rsyslog.conf"
run_demo_cmd "Reiniciamos rsyslog" "sudo systemctl restart rsyslog"
run_demo_cmd "Generamos log de prueba" "logger -p local0.info 'RHCSA test log entry'"
run_demo_cmd "Verificamos en rsyslog" "cat /var/log/rhcsa-test.log || echo 'Verificación'"
sleep 2.0

# 4. Probar y Validar
clear_section "RHCSA Módulo 11: Logging Avanzado - Tema: 4. Probar Logs"
run_demo_cmd "Generamos más logs" "logger 'RHCSA final test'"
run_demo_cmd "Verificamos en journal" "journalctl -n 2 --no-pager | grep -i rhcsa || echo 'Check'"
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
