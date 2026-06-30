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
            echo -e "    ${YELLOW}SUGGESTION:${NC} Revisa instructions.md y demo.sh. Usa 'sudo vgs/lvs', 'df -T /mnt/docs', 'mountpoint' para depurar."
        fi
    fi
}

# Optional explain header
if $EXPLAIN_MODE; then
    echo -e "${YELLOW}EXPLAIN MODE: Mostrando descripción de cada verificación + sugerencias en fallos.${NC}"
    echo
fi

echo -e "${CYAN}================================================================${NC}"
echo -e "${CYAN}         Evaluador de Reto: Módulo 07 - Almacenamiento Local    ${NC}"
echo -e "${CYAN}================================================================${NC}"
echo

# 1. Verificar si el Volume Group 'vg_labs' existe
if sudo vgs vg_labs &>/dev/null; then
    print_result "Volume Group 'vg_labs'" "SUCCESS" "El Volume Group vg_labs existe y es válido."
else
    print_result "Volume Group 'vg_labs'" "FAIL" "No se encontró el Volume Group vg_labs."
fi

# 2. Verificar Logical Volume 'lv_docs' y su tamaño aproximado (800MB)
if sudo lvs /dev/vg_labs/lv_docs &>/dev/null; then
    SIZE_KB=$(sudo lvs --noheadings -o lv_size --units k /dev/vg_labs/lv_docs | tr -d ' ' | tr -d 'k' | cut -d. -f1)
    # 800MB es aprox 819200KB. Permitimos un margen amplio (780MB a 820MB)
    if [ "$SIZE_KB" -gt 790000 ] && [ "$SIZE_KB" -lt 830000 ]; then
        print_result "Logical Volume 'lv_docs'" "SUCCESS" "El volumen lv_docs existe y tiene el tamaño correcto de 800M."
    else
        print_result "Logical Volume 'lv_docs'" "FAIL" "El volumen lv_docs existe pero su tamaño es de ${SIZE_KB}KB en vez de ~800M."
    fi
else
    print_result "Logical Volume 'lv_docs'" "FAIL" "No se encontró el Logical Volume lv_docs."
fi

# 3. Verificar Montaje de 'lv_docs' en /mnt/docs
if mountpoint -q /mnt/docs; then
    FS_TYPE=$(df -T /mnt/docs | tail -n 1 | awk '{print $2}')
    if [ "$FS_TYPE" = "xfs" ]; then
        print_result "Montaje 'lv_docs'" "SUCCESS" "El volumen está montado en /mnt/docs formateado en XFS."
    else
        print_result "Montaje 'lv_docs'" "FAIL" "El volumen está montado pero con tipo de filesystem '$FS_TYPE' en vez de XFS."
    fi
else
    print_result "Montaje 'lv_docs'" "FAIL" "El volumen no está montado en /mnt/docs."
fi

# 4. Verificar extensión de 'lv_data' a 1G
if sudo lvs /dev/vg_labs/lv_data &>/dev/null; then
    SIZE_KB_DATA=$(sudo lvs --noheadings -o lv_size --units k /dev/vg_labs/lv_data | tr -d ' ' | tr -d 'k' | cut -d. -f1)
    if [ "$SIZE_KB_DATA" -ge 1000000 ]; then
        print_result "Extensión Logical Volume 'lv_data'" "SUCCESS" "El volumen lv_data se extendió correctamente a 1G o más."
    else
        print_result "Extensión Logical Volume 'lv_data'" "FAIL" "El volumen lv_data tiene un tamaño de ${SIZE_KB_DATA}KB (debe ser al menos 1G)."
    fi
else
    print_result "Extensión Logical Volume 'lv_data'" "FAIL" "No se encontró el Logical Volume lv_data."
fi

# 5. Verificar LVM VDO 'vdo_vol'
if sudo lvs /dev/vg_labs/vdo_vol &>/dev/null; then
    # Comprobar si es un volumen de tipo VDO
    VDO_CHECK=$(sudo lvs -o lv_layout /dev/vg_labs/vdo_vol | grep -w "vdo")
    if [ -n "$VDO_CHECK" ] || sudo lvs /dev/vg_labs/vdo_vol -o lv_attr | grep -E "^v" &>/dev/null; then
        print_result "Volumen Optimizado LVM VDO" "SUCCESS" "El volumen VDO 'vdo_vol' fue creado correctamente."
    else
        print_result "Volumen Optimizado LVM VDO" "FAIL" "El volumen vdo_vol existe pero no está configurado como tipo vdo."
    fi
else
    print_result "Volumen Optimizado LVM VDO" "FAIL" "No se encontró el volumen vdo_vol."
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
