#!/bin/bash

# ANSI colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CHALLENGE_DIR="$BASE_DIR/challenge"

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
            echo -e "    ${YELLOW}SUGGESTION:${NC} Revisa instructions.md. Usa 'dnf repolist', 'rpm -q', 'createrepo' para depurar."
        fi
    fi
}

if $EXPLAIN_MODE; then
    echo -e "${YELLOW}EXPLAIN MODE: Mostrando descripción de cada verificación + sugerencias en fallos.${NC}"
    echo
fi

echo -e "${CYAN}================================================================${NC}"
echo -e "${CYAN}         Evaluador de Reto: Módulo 10 - Gestión de Paquetes     ${NC}"
echo -e "${CYAN}================================================================${NC}"
echo

# 1. Validar sysctl param
if sysctl net.ipv4.ip_forward &>/dev/null; then
    print_result "Parámetro sysctl" "SUCCESS" "net.ipv4.ip_forward accesible."
else
    print_result "Parámetro sysctl" "FAIL" "Problema accediendo parámetro."
fi

# 2. Validar cambio persistente (simulado con archivo)
if [ -f /etc/sysctl.d/99-test.conf ] || grep -q "ip_forward" /etc/sysctl.conf 2>/dev/null; then
    print_result "Cambio persistente" "SUCCESS" "Config persistente detectada."
else
    print_result "Cambio persistente" "FAIL" "No se detectó config persistente."
fi

# 3. Validar kernel param
if sysctl kernel.hostname &>/dev/null; then
    print_result "Kernel param" "SUCCESS" "kernel.hostname accesible."
else
    print_result "Kernel param" "FAIL" "Problema con kernel param."
fi

# 4. Validar challenge config
if [ -f "$CHALLENGE_DIR/sysctl.conf" ]; then
    print_result "Challenge config" "SUCCESS" "sysctl config in challenge."
else
    print_result "Challenge config" "FAIL" "No config."
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
