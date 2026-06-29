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
    eval "$cmd"
    echo
    sleep 5.0
}

# Helper to clean terminal and show section header
clear_section() {
    clear
    echo -e "${CYAN}================================================================${NC}"
    echo -e "${CYAN}    RHCSA Módulo 07: Administración de Almacenamiento Local     ${NC}"
    echo -e "${CYAN}    Tema: $1${NC}"
    echo -e "${CYAN}================================================================${NC}"
    echo
    sleep 2.0
}

# 1. Particionamiento y Discos
clear_section "1. Inspección de Discos y Particiones"
run_demo_cmd "Listamos todos los dispositivos de bloque y discos instalados" "lsblk"
run_demo_cmd "Mostramos información detallada de los sistemas de archivos montados" "df -hT | head -n 6"
run_demo_cmd "Simulamos crear una partición GPT usando gdisk" "echo 'gdisk /dev/sdb' (ejemplo interactivo de gdisk)"
run_demo_cmd "Simulamos crear una partición MBR usando fdisk" "echo 'fdisk /dev/sdb' (ejemplo interactivo de fdisk)"
sleep 2.0

# 2. Creación de Componentes LVM
clear_section "2. Creación de Physical Volumes, Volume Groups y Logical Volumes"
run_demo_cmd "Simulamos inicializar un Physical Volume (PV)" "echo 'pvcreate /dev/sdb1' (ejemplo de pvcreate)"
run_demo_cmd "Listamos los PVs activos en el sistema" "sudo pvs 2>/dev/null || echo '(Requiere privilegios de root para LVM)'"
run_demo_cmd "Simulamos crear un Volume Group (VG)" "echo 'vgcreate vg_labs /dev/sdb1' (ejemplo de vgcreate)"
run_demo_cmd "Simulamos crear un Logical Volume (LV) de 1GB" "echo 'lvcreate -L 1G -n lv_docs vg_labs' (ejemplo de lvcreate)"
sleep 2.0

# 3. Formateo, Montaje y Extensión
clear_section "3. Formateo, Montaje y Extensión en Caliente"
run_demo_cmd "Simulamos formatear el volumen lógico en XFS" "echo 'mkfs.xfs /dev/vg_labs/lv_docs' (ejemplo de mkfs)"
run_demo_cmd "Simulamos montar el volumen de manera persistente en /etc/fstab" "echo '/dev/vg_labs/lv_docs /mnt/docs xfs defaults 0 0' (ejemplo de fstab)"
run_demo_cmd "Simulamos extender el volumen lógico a 2GB y su filesystem a la vez" "echo 'lvextend -L 2G -r /dev/vg_labs/lv_docs' (ejemplo de lvextend)"
run_demo_cmd "Mostramos las propiedades detalladas de un VG existente" "sudo vgs 2>/dev/null || echo '(Requiere root para LVM)'"
sleep 2.0

# 4. LVM VDO (Virtual Data Optimizer)
clear_section "4. Optimización de Espacio mediante LVM VDO"
run_demo_cmd "Simulamos crear un volumen VDO con deduplicación y compresión activa" "echo 'lvcreate --type vdo --name vdo_vol -L 4G -V 8G vg_labs' (ejemplo de vdo)"
run_demo_cmd "Mostramos el estado y estadísticas de los volúmenes lógicos" "sudo lvs 2>/dev/null || echo '(Requiere root para LVM)'"
run_demo_cmd "Visualizamos la información de montaje y tamaño en caliente" "sudo mount | grep -E '(docs|vdo)' || echo '(No hay montajes LVM activos)'"
run_demo_cmd "Simulamos cómo recargar las tablas de LVM si cambiamos discos" "echo 'vgscan && pvscan' (ejemplo de scan)"
sleep 2.0

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
