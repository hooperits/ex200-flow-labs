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

# 1. Validar timer unit
if [ -f /etc/systemd/system/rhcsa-timer.timer ]; then
    print_result "Timer unit" "SUCCESS" "rhcsa-timer.timer existe."
else
    print_result "Timer unit" "FAIL" "No se encontró timer."
fi

# 2. Validar servicio
if [ -f /etc/systemd/system/rhcsa-timer.service ]; then
    print_result "Servicio timer" "SUCCESS" "Servicio asociado existe."
else
    print_result "Servicio timer" "FAIL" "No se encontró servicio."
fi

# 3. Validar timer activo
if systemctl list-timers | grep -q rhcsa; then
    print_result "Timer activo" "SUCCESS" "Timer listado."
else
    print_result "Timer activo" "FAIL" "No se detectó timer activo."
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
