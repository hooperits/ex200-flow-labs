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

# 1. Configurar un Repositorio
clear_section "RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 1. Configurar un Repositorio"
run_demo_cmd "Creamos el archivo de repo local" "mkdir -p /tmp/local-repo && echo '[local-test]
name=Local Test Repo
baseurl=file:///srv/nfs_export
enabled=1
gpgcheck=0' > /etc/yum.repos.d/local-test.repo"
run_demo_cmd "Verificamos repositorios" "dnf repolist --enabled | head -3"
rm -f /etc/yum.repos.d/local-test.repo
sleep 1.5

# 2. Instalar y Gestionar Paquetes con DNF5
clear_section "RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 2. Paquetes con DNF5"
run_demo_cmd "Buscamos un paquete" "dnf search httpd | head -2"
run_demo_cmd "Instalamos httpd" "dnf install -y httpd &>/dev/null || true"
run_demo_cmd "Verificamos" "rpm -q httpd"
run_demo_cmd "Actualizamos bash" "dnf update -y bash &>/dev/null || true"
run_demo_cmd "Removemos httpd" "dnf remove -y httpd &>/dev/null || true"
sleep 1.5

# 3. Gestionar con Flatpak
clear_section "RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 3. Flatpak"
run_demo_cmd "Instalamos flatpak" "dnf install -y flatpak &>/dev/null || true"
run_demo_cmd "Agregamos Flathub" "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 2>/dev/null || true"
run_demo_cmd "Instalamos app de ejemplo (puede variar)" "flatpak install -y flathub org.gnome.Calculator 2>/dev/null || echo 'Flatpak de ejemplo (puede necesitar red)'"
run_demo_cmd "Listamos apps Flatpak" "flatpak list | head -3 || true"
sleep 1.5

# 4. Usar Módulos
clear_section "RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 4. Módulos AppStream"
run_demo_cmd "Listamos módulos" "dnf module list | head -4"
run_demo_cmd "Habilitamos módulo de ejemplo" "dnf module enable -y nodejs:18 2>/dev/null || echo 'Módulo ejemplo (puede variar)'"
run_demo_cmd "Verificamos módulo" "dnf module list --enabled | head -2 || true"
sleep 1.5

# 5. Crear Repositorio Local
clear_section "RHCSA Módulo 10: Gestión de Paquetes (RHEL 10) - 5. Repositorio Local"
run_demo_cmd "Preparamos directorio local" "mkdir -p challenge/local-repo && cp /var/cache/dnf/*/*/packages/bash*.rpm challenge/local-repo/ 2>/dev/null || touch challenge/local-repo/dummy.rpm"
run_demo_cmd "Creamos metadatos" "createrepo challenge/local-repo"
run_demo_cmd "Configuramos .repo local" "echo '[my-local]
name=My Local Repo
baseurl=file://$(pwd)/challenge/local-repo
enabled=1
gpgcheck=0' > /etc/yum.repos.d/my-local.repo"
run_demo_cmd "Verificamos nuevo repo" "dnf repolist | grep my-local || true"
rm -f /etc/yum.repos.d/my-local.repo
rm -rf challenge/local-repo
sleep 1.5

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
