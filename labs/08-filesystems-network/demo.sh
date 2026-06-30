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

# 1. Sistemas de Archivos locales
clear_section "RHCSA Módulo 08: Sistemas de Archivos y Montajes de Red - Tema: 1. Identificación y Formateo de Archivos Locales"
run_demo_cmd "Listamos los UUIDs de todos los dispositivos de almacenamiento" "sudo blkid | head -n 4"
run_demo_cmd "Mostramos las propiedades y tipos de los sistemas de archivos montados" "findmnt -l --types ext4,xfs | head -n 5"
run_demo_cmd "Simulamos formatear un dispositivo usando mkfs.ext4" "echo 'mkfs.ext4 /dev/sdb1' (ejemplo de mkfs)"
run_demo_cmd "Simulamos formatear un dispositivo usando mkfs.xfs" "echo 'mkfs.xfs -f /dev/sdb1' (ejemplo de mkfs)"
sleep 2.0

# 2. Montajes Locales Persistentes
clear_section "RHCSA Módulo 08: Sistemas de Archivos y Montajes de Red - Tema: 2. Montajes Persistentes en /etc/fstab"
run_demo_cmd "Visualizamos las líneas activas dentro de /etc/fstab" "grep -v '^#' /etc/fstab | grep -v '^$'"
run_demo_cmd "Comprobamos el estado del montaje actual" "mount | grep -E '^/dev/' | head -n 4"
run_demo_cmd "Simulamos cómo montar de forma segura todas las entradas de fstab" "sudo mount -a (comando de prueba)"
run_demo_cmd "Simulamos cómo desmontar un dispositivo de forma segura" "echo 'umount /mnt/docs' (ejemplo de umount)"
sleep 2.0

# 3. Montajes de Red (NFS / SMB)
clear_section "RHCSA Módulo 08: Sistemas de Archivos y Montajes de Red - Tema: 3. Montajes Manuales de Red (NFS y SMB)"
run_demo_cmd "Buscamos paquetes cliente de NFS instalados en la VM" "rpm -qa | grep nfs-utils || echo 'nfs-utils no instalado'"
run_demo_cmd "Simulamos cómo montar de forma manual un recurso NFS remoto" "echo 'mount -t nfs 192.168.56.10:/exports /mnt/nfs' (ejemplo de nfs)"
run_demo_cmd "Simulamos cómo montar un recurso compartido de red Windows (SMB/CIFS)" "echo 'mount -t cifs -o username=user //192.168.56.10/share /mnt/smb' (ejemplo de smb)"
run_demo_cmd "Listamos los recursos NFS exportados por un servidor usando showmount" "echo 'showmount -e 192.168.56.10' (ejemplo de showmount)"
sleep 2.0

# 4. Montajes a Demanda (Autofs)
clear_section "RHCSA Módulo 08: Sistemas de Archivos y Montajes de Red - Tema: 4. Automontajes Dinámicos con Autofs"
run_demo_cmd "Comprobamos el estado del daemon autofs" "systemctl status autofs 2>/dev/null || echo 'autofs no activo o no instalado'"
run_demo_cmd "Leemos el mapa maestro principal de autofs" "cat /etc/auto.master 2>/dev/null || echo '/etc/auto.master no existe'"
run_demo_cmd "Simulamos la estructura de un mapa de mapeo secundario" "echo 'nfs_share  -fstype=nfs,rw  192.168.56.10:/exports' (ejemplo de mapa)"
run_demo_cmd "Simulamos cómo recargar y probar el automontaje en caliente" "echo 'systemctl restart autofs && cd /shares/nfs_share' (ejemplo de prueba)"
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
