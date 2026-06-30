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

# 1. Configurar Autenticación por Claves SSH
clear_section "RHCSA Módulo 12: SSH y Sudoers - Tema: 1. Configurar Autenticación por Claves SSH"
run_demo_cmd "Generamos par de claves" "ssh-keygen -t rsa -f /tmp/id_rsa_test -N '' -q"
run_demo_cmd "Creamos directorio .ssh" "mkdir -p ~/.ssh && chmod 700 ~/.ssh"
run_demo_cmd "Copiamos clave pública" "cat /tmp/id_rsa_test.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
run_demo_cmd "Verificamos" "ls -l ~/.ssh/authorized_keys"
rm -f /tmp/id_rsa_test*
sleep 2.0

# 2. Configurar sudoers
clear_section "RHCSA Módulo 12: SSH y Sudoers - Tema: 2. Configurar sudoers"
run_demo_cmd "Creamos sudoers.d para grupo" "echo '%wheel ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/wheel-nopasswd"
run_demo_cmd "Verificamos sintaxis" "sudo visudo -c -f /etc/sudoers.d/wheel-nopasswd || echo 'Verificación'"
run_demo_cmd "Prueba (simulada)" "sudo -l | head -3 || true"
sleep 2.0

# 3. Restringir Acceso SSH
clear_section "RHCSA Módulo 12: SSH y Sudoers - Tema: 3. Restringir Acceso SSH"
run_demo_cmd "Backup sshd_config" "sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak"
run_demo_cmd "Deshabilitamos root login" "sudo sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config"
run_demo_cmd "Reiniciamos sshd" "sudo systemctl restart sshd || echo 'Simulado'"
run_demo_cmd "Verificamos config" "grep PermitRootLogin /etc/ssh/sshd_config"
sleep 2.0

# 4. Probar y Validar
clear_section "RHCSA Módulo 12: SSH y Sudoers - Tema: 4. Probar Config"
run_demo_cmd "Verificamos usuarios" "id vagrant"
run_demo_cmd "Prueba sudo (simulada)" "sudo -u vagrant echo 'test' || true"
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
