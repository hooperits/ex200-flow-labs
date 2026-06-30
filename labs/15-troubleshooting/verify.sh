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
            echo -e "    ${YELLOW}SUGGESTION:${NC} Revisa instructions.md. Usa 'journalctl', 'systemctl status', 'ip addr', 'ss' para depurar servicios, permisos, red."
        fi
    fi
}

if $EXPLAIN_MODE; then
    echo -e "${YELLOW}EXPLAIN MODE: Mostrando descripción de cada verificación + sugerencias en fallos.${NC}"
    echo
fi

echo -e "${CYAN}================================================================${NC}"
echo -e "${CYAN}         Evaluador de Reto: Módulo 15 - Troubleshooting         ${NC}"
echo -e "${CYAN}================================================================${NC}"
echo

# 1. Validar diagnóstico servicio
if journalctl -u sshd --no-pager | grep -q sshd; then
    print_result "Diagnóstico servicio" "SUCCESS" "Logs de servicio accesibles."
else
    print_result "Diagnóstico servicio" "FAIL" "Problema con logs."
fi

# 2. Validar permisos fix (simulado en demo, check challenge or /tmp if present)
if [ -f "$CHALLENGE_DIR/troubleshoot.log" ] || [ -f /tmp/broken_perm.txt ]; then
    print_result "Permisos fix" "SUCCESS" "Evidencia de fix o log de diagnóstico presente."
else
    print_result "Permisos fix" "FAIL" "No se detectó fix o log."
fi

# 3. Validar network
if ip addr | grep -q 127.0.0.1; then
    print_result "Network diag" "SUCCESS" "IP local accesible."
else
    print_result "Network diag" "FAIL" "Problema network."
fi

# 4. Validar log diagnóstico
if [ -f "$CHALLENGE_DIR/troubleshoot.log" ]; then
    print_result "Log diagnóstico" "SUCCESS" "Log de diagnóstico en challenge."
else
    print_result "Log diagnóstico" "FAIL" "No se creó log."
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
