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

# 1. Configurar un Repositorio DNF
clear_section "RHCSA Módulo 10: Gestión de Paquetes - Tema: 1. Configurar un Repositorio DNF"
run_demo_cmd "Instalamos createrepo si es necesario" "dnf install -y createrepo &>/dev/null || true"
run_demo_cmd "Creamos un directorio para el repo local" "mkdir -p /tmp/local-repo && cp /var/cache/dnf/*/packages/bash*.rpm /tmp/local-repo/ 2>/dev/null || echo 'Usando paquetes de ejemplo'"
run_demo_cmd "Creamos el repositorio local" "createrepo /tmp/local-repo"
run_demo_cmd "Creamos el archivo .repo" "echo '[local-test]
name=Local Test Repo
baseurl=file:///tmp/local-repo
enabled=1
gpgcheck=0' > /etc/yum.repos.d/local-test.repo"
run_demo_cmd "Verificamos los repositorios" "dnf repolist --enabled | head -5"
rm -f /etc/yum.repos.d/local-test.repo
sleep 2.0

# 2. Instalar y Gestionar Paquetes con DNF
clear_section "RHCSA Módulo 10: Gestión de Paquetes - Tema: 2. Instalar y Gestionar Paquetes con DNF"
run_demo_cmd "Buscamos un paquete" "dnf search httpd | head -3"
run_demo_cmd "Instalamos httpd (si no está)" "dnf install -y httpd &>/dev/null || true"
run_demo_cmd "Verificamos instalación" "rpm -q httpd"
run_demo_cmd "Actualizamos información de paquetes" "dnf check-update | head -3 || true"
run_demo_cmd "Limpiamos cache de dnf" "dnf clean all"
sleep 2.0

# 3. Usar Módulos DNF (AppStreams)
clear_section "RHCSA Módulo 10: Gestión de Paquetes - Tema: 3. Usar Módulos DNF"
run_demo_cmd "Listamos módulos disponibles" "dnf module list | head -5"
run_demo_cmd "Habilitamos un módulo de ejemplo (si disponible)" "dnf module enable -y nodejs:18 2>/dev/null || echo 'Módulo de ejemplo (puede variar por versión)'"
run_demo_cmd "Instalamos desde módulo" "dnf module install -y nodejs:18/minimal 2>/dev/null || echo 'Simulando instalación de módulo'"
run_demo_cmd "Verificamos módulo activo" "dnf module list --enabled | grep nodejs || echo 'Verificación de módulo'"
sleep 2.0

# 4. Crear y Usar un Repositorio Local
clear_section "RHCSA Módulo 10: Gestión de Paquetes - Tema: 4. Crear un Repositorio Local"
run_demo_cmd "Preparamos directorio para repo local" "mkdir -p /tmp/myrepo && cp /var/cache/dnf/*/packages/coreutils*.rpm /tmp/myrepo/ 2>/dev/null || touch /tmp/myrepo/dummy.rpm"
run_demo_cmd "Creamos metadatos del repo" "createrepo /tmp/myrepo"
run_demo_cmd "Configuramos repo que apunta al local" "echo '[my-local]
name=My Local Repo
baseurl=file:///tmp/myrepo
enabled=1
gpgcheck=0' > /etc/yum.repos.d/my-local.repo"
run_demo_cmd "Verificamos el nuevo repo" "dnf repolist | grep my-local || true"
rm -rf /tmp/myrepo /etc/yum.repos.d/my-local.repo
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
