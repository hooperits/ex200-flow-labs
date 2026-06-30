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

# 1. Particionamiento y Discos
clear_section "RHCSA Módulo 07: Almacenamiento Local - Tema: 1. Discos y Particiones"
run_demo_cmd "Listamos todos los dispositivos de bloque y discos instalados" "lsblk"
run_demo_cmd "Mostramos información detallada de los sistemas de archivos montados" "df -hT | head -n 6"
run_demo_cmd "Ejemplo de creación de partición GPT (interactivo)" "echo 'gdisk /dev/sdb'   # gdisk es interactivo, se usa en el reto real"
run_demo_cmd "Ejemplo de creación de partición MBR (interactivo)" "echo 'fdisk /dev/sdb'   # fdisk es interactivo"
sleep 2.0

# 2. Creación de Componentes LVM - ahora con ejecución real
clear_section "RHCSA Módulo 07: Almacenamiento Local - Tema: 2. PV, VG y LV"
run_demo_cmd "Inicializamos /dev/sdb como Physical Volume (PV)" "sudo pvcreate -f /dev/sdb"
run_demo_cmd "Listamos los PVs activos" "sudo pvs"
run_demo_cmd "Creamos Volume Group (VG) vg_demo" "sudo vgcreate -f vg_demo /dev/sdb"
run_demo_cmd "Creamos Logical Volume (LV) lv_demo de 200M" "sudo lvcreate -L 200M -n lv_demo vg_demo"
sleep 2.0

# 3. Formateo, Montaje y Extensión - ejecución real
clear_section "RHCSA Módulo 07: Almacenamiento Local - Tema: 3. Formateo y Montaje"
run_demo_cmd "Formateamos el LV en XFS" "sudo mkfs.xfs -f /dev/vg_demo/lv_demo"
run_demo_cmd "Creamos punto de montaje y montamos" "sudo mkdir -p /mnt/demo && sudo mount /dev/vg_demo/lv_demo /mnt/demo"
run_demo_cmd "Mostramos el montaje" "df -hT /mnt/demo"
run_demo_cmd "Extendemos el LV a 400M y redimensionamos FS" "sudo lvextend -L 400M -r /dev/vg_demo/lv_demo"
run_demo_cmd "Verificamos el nuevo tamaño" "df -hT /mnt/demo"
sleep 2.0

# 4. LVM VDO - mantenemos ejemplo ya que requiere configuración especial
clear_section "RHCSA Módulo 07: Almacenamiento Local - Tema: 4. LVM VDO"
run_demo_cmd "Ejemplo de creación de volumen VDO (requiere preparación)" "echo 'sudo lvcreate --type vdo --name vdo_vol -L 1G -V 2G vg_demo'   # VDO optimizado"
run_demo_cmd "Mostramos LVs" "sudo lvs"
run_demo_cmd "Ejemplo de formateo y montaje VDO" "echo 'sudo mkfs.xfs /dev/vg_demo/vdo_vol && sudo mount /dev/vg_demo/vdo_vol /mnt/vdo'"

# Limpieza al final del demo (para dejar el entorno limpio)
run_demo_cmd "Desmontamos y limpiamos para el demo" "sudo umount /mnt/demo 2>/dev/null; sudo lvremove -f /dev/vg_demo/lv_demo 2>/dev/null; sudo vgremove -f vg_demo 2>/dev/null; sudo pvremove -f /dev/sdb 2>/dev/null; sudo rm -rf /mnt/demo"

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
