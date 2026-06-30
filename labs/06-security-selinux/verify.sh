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
            echo -e "    ${YELLOW}SUGGESTION:${NC} Revisa instructions.md. Usa 'getsebool', 'ls -Z', 'semanage', 'setenforce' para depurar SELinux."
        fi
    fi
}

if $EXPLAIN_MODE; then
    echo -e "${YELLOW}EXPLAIN MODE: Mostrando descripción de cada verificación + sugerencias en fallos.${NC}"
    echo
fi

echo -e "${CYAN}================================================================${NC}"
echo -e "${CYAN}         Evaluador de Reto: Módulo 06 - Seguridad y SELinux     ${NC}"
echo -e "${CYAN}================================================================${NC}"
echo

# 1. Verificar servicio http en firewalld (permanente)
if command -v firewall-cmd &>/dev/null; then
    FW_SERVICES=$(sudo firewall-cmd --permanent --zone=public --list-services 2>/dev/null)
    if echo "$FW_SERVICES" | grep -qw "http"; then
        print_result "Firewall - Servicio HTTP" "SUCCESS" "El servicio http está permitido de forma permanente."
    else
        print_result "Firewall - Servicio HTTP" "FAIL" "El servicio http no está permitido en la configuración permanente."
    fi
else
    print_result "Firewall - Servicio HTTP" "FAIL" "firewall-cmd no está disponible en este sistema."
fi

# 2. Verificar puerto 82/tcp en firewalld (permanente)
if command -v firewall-cmd &>/dev/null; then
    FW_PORTS=$(sudo firewall-cmd --permanent --zone=public --list-ports 2>/dev/null)
    if echo "$FW_PORTS" | grep -qw "82/tcp"; then
        print_result "Firewall - Puerto 82/tcp" "SUCCESS" "El puerto 82/tcp está permitido de forma permanente."
    else
        print_result "Firewall - Puerto 82/tcp" "FAIL" "El puerto 82/tcp no está permitido en la configuración permanente."
    fi
else
    print_result "Firewall - Puerto 82/tcp" "FAIL" "firewall-cmd no está disponible."
fi

# 3. Verificar existencia del directorio /var/www/custom_html y su contexto SELinux
DIR="/var/www/custom_html"
if [ -d "$DIR" ]; then
    if command -v getenforce &>/dev/null; then
        CONTEXT=$(ls -dZ "$DIR" 2>/dev/null | awk '{print $1}')
        if echo "$CONTEXT" | grep -q "httpd_sys_content_t"; then
            print_result "SELinux - Contexto de Directorio" "SUCCESS" "El directorio tiene el contexto 'httpd_sys_content_t' correcto."
        else
            print_result "SELinux - Contexto de Directorio" "FAIL" "El directorio tiene el contexto '$CONTEXT' en vez de 'httpd_sys_content_t'."
        fi
    else
        # Si SELinux no está instalado (como en WSL sin SELinux), comprobamos al menos que exista el directorio
        print_result "SELinux - Contexto de Directorio" "SUCCESS" "El directorio existe (SELinux no está activo para validar el contexto)."
    fi
else
    print_result "SELinux - Contexto de Directorio" "FAIL" "El directorio '$DIR' no existe."
fi

# 4. Verificar el Booleano httpd_enable_homedirs
if command -v getsebool &>/dev/null; then
    BOOL_STATE=$(getsebool httpd_enable_homedirs 2>/dev/null)
    if echo "$BOOL_STATE" | grep -q "on"; then
        print_result "SELinux - Booleano httpd_enable_homedirs" "SUCCESS" "El booleano httpd_enable_homedirs está activo (on)."
    else
        print_result "SELinux - Booleano httpd_enable_homedirs" "FAIL" "El booleano httpd_enable_homedirs está inactivo (off)."
    fi
else
    print_result "SELinux - Booleano httpd_enable_homedirs" "FAIL" "SELinux (getsebool) no está disponible en este sistema."
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
