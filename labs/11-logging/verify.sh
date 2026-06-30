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

# 1. Validar journal persistente
if [ -d /var/log/journal ]; then
    print_result "Persistencia Journal" "SUCCESS" "Directorio /var/log/journal existe."
else
    print_result "Persistencia Journal" "FAIL" "No se encontró /var/log/journal."
fi

# 2. Validar rsyslog config
if grep -q "rhcsa-test.log" /etc/rsyslog.conf 2>/dev/null; then
    print_result "Regla rsyslog" "SUCCESS" "Regla para rhcsa-test.log presente."
else
    print_result "Regla rsyslog" "FAIL" "No se encontró regla rsyslog."
fi

# 3. Validar log de prueba
if [ -f /var/log/rhcsa-test.log ] || journalctl | grep -q "RHCSA"; then
    print_result "Log de Prueba" "SUCCESS" "Se detectaron logs de prueba."
else
    print_result "Log de Prueba" "FAIL" "No se detectaron logs de prueba."
fi

# 4. Validar journal restart or config
if systemctl is-active systemd-journald &>/dev/null; then
    print_result "Journald activo" "SUCCESS" "systemd-journald está activo."
else
    print_result "Journald activo" "FAIL" "systemd-journald no activo."
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
