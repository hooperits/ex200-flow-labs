#!/bin/bash

# ANSI colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

FAILED_TESTS=0
EXPLAIN_MODE=false
if [[ "${1:-}" == "--explain" ]]; then
    EXPLAIN_MODE=true
fi

print_result() {
    local test_name="$1"
    local status="$2"
    local message="$3"
    
    if [ "$status" = "SUCCESS" ]; then
        echo -e "[ ${GREEN}PASSED${NC} ] $test_name - $message"
    else
        echo -e "[ ${RED}FAILED${NC} ] $test_name - $message"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        if $EXPLAIN_MODE; then
            echo -e "    ${YELLOW}SUGGESTION:${NC} Revisa instructions.md. Usa 'blkid', 'mount', 'cat /etc/fstab', 'systemctl' para depurar."
        fi
    fi
}

if $EXPLAIN_MODE; then
    echo -e "${YELLOW}EXPLAIN MODE: Mostrando descripción de cada verificación + sugerencias en fallos.${NC}"
    echo
fi

echo -e "${CYAN}================================================================${NC}"
echo -e "${CYAN}         Evaluador de Reto: Módulo 08 - Montajes y Autofs       ${NC}"
echo -e "${CYAN}================================================================${NC}"
echo

# 1. Verificar si /etc/fstab contiene una entrada montando en /mnt/data_local usando UUID
if [ -f "/etc/fstab" ]; then
    FSTAB_LINE=$(grep -v "^#" /etc/fstab | grep "/mnt/data_local")
    if [ -n "$FSTAB_LINE" ]; then
        if echo "$FSTAB_LINE" | grep -qi "UUID="; then
            print_result "Montaje Local Persistente por UUID" "SUCCESS" "Se configuró /mnt/data_local usando UUID en /etc/fstab."
        else
            print_result "Montaje Local Persistente por UUID" "FAIL" "Se encontró la ruta de montaje, pero no se está utilizando el UUID en /etc/fstab."
        fi
    else
        print_result "Montaje Local Persistente por UUID" "FAIL" "No se encontró ninguna línea de montaje para '/mnt/data_local' en /etc/fstab."
    fi
else
    print_result "Montaje Local Persistente por UUID" "FAIL" "No existe el archivo /etc/fstab."
fi

# 2. Verificar que /mnt/data_local esté montado físicamente
if mountpoint -q /mnt/data_local; then
    print_result "Montaje Físico Local" "SUCCESS" "El directorio /mnt/data_local está actualmente montado."
else
    print_result "Montaje Físico Local" "FAIL" "El directorio /mnt/data_local no está montado."
fi

# 3. Verificar servicio autofs habilitado y activo
if systemctl is-enabled autofs &>/dev/null; then
    if systemctl is-active autofs &>/dev/null; then
        print_result "Servicio Autofs" "SUCCESS" "El servicio autofs está habilitado y en ejecución."
    else
        print_result "Servicio Autofs" "FAIL" "El servicio autofs está habilitado pero no está corriendo."
    fi
else
    print_result "Servicio Autofs" "FAIL" "El servicio autofs no está habilitado."
fi

# 4. Verificar configuración de autofs maps
if [ -f "/etc/auto.master" ] && [ -f "/etc/auto.shares" ]; then
    MASTER_CHECK=$(grep -v "^#" /etc/auto.master | grep -E "^/shares\s+/etc/auto.shares")
    MAP_CHECK=$(grep -v "^#" /etc/auto.shares | grep -E "^nfs_share\s+.*localhost:/srv/nfs_export")
    
    if [ -n "$MASTER_CHECK" ] && [ -n "$MAP_CHECK" ]; then
        print_result "Configuración de Mapas Autofs" "SUCCESS" "El mapa maestro y secundario están configurados correctamente."
    else
        print_result "Configuración de Mapas Autofs" "FAIL" "Falta la entrada en /etc/auto.master o en /etc/auto.shares."
    fi
else
    print_result "Configuración de Mapas Autofs" "FAIL" "Los archivos /etc/auto.master o /etc/auto.shares no existen."
fi

# 5. Forzar el automontaje dinámico accediendo al directorio y verificando el montaje
# (Simulamos un acceso rápido)
ls -la /shares/nfs_share &>/dev/null
if mount | grep -q "localhost:/srv/nfs_export"; then
    print_result "Verificación Automontaje Autofs" "SUCCESS" "El recurso localhost:/srv/nfs_export se montó dinámicamente en /shares/nfs_share."
else
    print_result "Verificación Automontaje Autofs" "FAIL" "El recurso NFS no se montó dinámicamente al intentar acceder."
fi

echo
echo -e "${CYAN}================================================================${NC}"
if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}      RESULTADO FINAL: ¡TODAS LAS PRUEBAS PASARON CON ÉXITO! (PASSED)${NC}"
    echo -e "${CYAN}================================================================${NC}"
    exit 0
else
    echo -e "${RED}      RESULTADO FINAL: ALGUNAS PRUEBAS FALLARON. (FAILED)${NC}"
    echo -e "${CYAN}================================================================${NC}"
    exit 1
fi
