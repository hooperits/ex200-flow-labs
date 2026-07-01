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

# 1. systemctl para servicios
clear_section "RHCSA Módulo 03: Operación del Sistema (RHEL 10) - Tema: 1. Servicios con systemctl"
run_demo_cmd "Comprobamos el estado del servicio sshd" "systemctl status sshd | head -n 5"
run_demo_cmd "Verificamos si un servicio está habilitado para el arranque" "systemctl is-enabled sshd"
run_demo_cmd "Verificamos si un servicio está actualmente activo" "systemctl is-active sshd"
run_demo_cmd "Listamos todos los servicios cargados en el sistema" "systemctl list-units --type=service --state=running | head -n 6"
sleep 2.0

# 2. Control de Targets
clear_section "RHCSA Módulo 03: Operación del Sistema (RHEL 10) - Tema: 2. Targets de Arranque"
run_demo_cmd "Obtenemos el target predeterminado del sistema" "systemctl get-default"
run_demo_cmd "Listamos los targets disponibles actualmente" "systemctl list-units --type=target | head -n 6"
run_demo_cmd "Simulamos cómo cambiar el target a modo consola (multi-user.target)" "echo 'systemctl set-default multi-user.target' (comando de demostración)"
run_demo_cmd "Simulamos cómo cambiar el target a modo gráfico (graphical.target)" "echo 'systemctl set-default graphical.target' (comando de demostración)"
sleep 2.0

# 3. Gestión de Procesos e Inspección de Logs (agrupado para alineación con letras)
clear_section "RHCSA Módulo 03: Operación del Sistema (RHEL 10) - Tema: 3. Procesos y Logs (journalctl)"
run_demo_cmd "Listamos procesos ordenados por consumo de recursos" "ps aux --sort=-%cpu | head -n 5"
run_demo_cmd "Buscamos un proceso específico por su nombre usando pgrep" "pgrep -l systemd | head -n 4"
run_demo_cmd "Mostramos la prioridad 'nice' de los procesos en ejecución" "ps -el | head -n 5"
run_demo_cmd "Simulamos cómo cambiar la prioridad de un proceso con renice" "echo 'renice -n 5 -p 1234' (ejemplo de renice)"
run_demo_cmd "Mostramos las últimas 5 líneas del log del sistema" "sudo journalctl -n 5 --no-pager"
run_demo_cmd "Filtramos los logs de un servicio específico como sshd" "sudo journalctl -u sshd -n 4 --no-pager"
run_demo_cmd "Filtramos los logs mostrando únicamente errores importantes con '-p err'" "sudo journalctl -p err -n 4 --no-pager"
run_demo_cmd "Mostramos los logs generados desde el arranque actual usando '-b'" "sudo journalctl -b -n 4 --no-pager"
sleep 2.0

# 4. Recuperación de root con rd.break en GRUB (alineado con estructura de letras)
clear_section "RHCSA Módulo 03: Operación del Sistema (RHEL 10) - Tema: 4. Recuperación root (rd.break)"
run_demo_cmd "Interrumpimos el arranque presionando e en el menú de GRUB" "echo 'Presiona e para editar la entrada'"
run_demo_cmd "Agregamos rd.break al final de la línea que empieza con linux" "echo 'Añade rd.break'"
run_demo_cmd "Boot con Ctrl+X o F10" "echo 'Continúa el arranque'"
run_demo_cmd "Remontamos /sysroot en modo escritura" "mount -o remount,rw /sysroot"
run_demo_cmd "Entramos al sistema con chroot" "chroot /sysroot"
run_demo_cmd "Cambiamos la contraseña de root" "passwd"
run_demo_cmd "Creamos el archivo para que SELinux relabel en el próximo boot" "touch /.autorelabel"
run_demo_cmd "Salimos del chroot y del entorno de recuperación" "exit ; exit"

# Fin de la demostración
clear
echo -e "${GREEN}================================================================${NC}"
echo -e "${GREEN}   ¡Demostración completada con éxito! Listo para el reto.       ${NC}"
echo -e "${GREEN}================================================================${NC}"
sleep 5.0
