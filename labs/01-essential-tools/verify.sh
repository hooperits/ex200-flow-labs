#!/bin/bash

# ANSI colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Determine script base directory dynamically
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CHALLENGE_DIR="$BASE_DIR/challenge"

# Status trackers
FAILED_TESTS=0
EXPLAIN_MODE=false
TASK_FILTER=""

if [[ "${1:-}" == "--explain" ]]; then
    EXPLAIN_MODE=true
elif [[ "${1:-}" == "--task" && -n "${2:-}" ]]; then
    TASK_FILTER="$2"
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
            echo -e "    ${YELLOW}SUGGESTION:${NC} Revisa instructions.md y demo.sh (o hints.md). Usa 'ls -li', 'stat', 'diff' para depurar los enlaces/permisos/grep."
        fi
    fi
}

# Optional explain header
if $EXPLAIN_MODE; then
    echo -e "${YELLOW}EXPLAIN MODE: Mostrando descripción de cada verificación + sugerencias en fallos.${NC}"
    echo
fi

echo -e "${CYAN}================================================================${NC}"
echo -e "${CYAN}         Evaluador de Reto: Módulo 01 - Herramientas Esenciales (RHEL 10)  ${NC}"
echo -e "${CYAN}================================================================${NC}"
echo

# 1. Validación de Enlace Simbólico (Soft Link)
if [ -L "$CHALLENGE_DIR/soft_link_ref" ]; then
    TARGET_PATH="$(readlink "$CHALLENGE_DIR/soft_link_ref")"
    if [[ "$TARGET_PATH" == "original_data.txt" || "$TARGET_PATH" == "$CHALLENGE_DIR/original_data.txt" ]]; then
        print_result "Enlace Simbólico" "SUCCESS" "El archivo 'soft_link_ref' es un enlace simbólico válido y apunta al origen."
    else
        print_result "Enlace Simbólico" "FAIL" "El enlace simbólico existe pero apunta a '$TARGET_PATH' en lugar de 'original_data.txt'."
    fi
else
    print_result "Enlace Simbólico" "FAIL" "No se encontró el enlace simbólico '$CHALLENGE_DIR/soft_link_ref'."
fi

# 2. Validación de Enlace Duro (Hard Link)
if [ -f "$CHALLENGE_DIR/hard_link_ref" ] && [ ! -L "$CHALLENGE_DIR/hard_link_ref" ]; then
    if [ "$CHALLENGE_DIR/hard_link_ref" -ef "$CHALLENGE_DIR/original_data.txt" ]; then
        print_result "Enlace Duro" "SUCCESS" "El archivo 'hard_link_ref' comparte el mismo inodo que 'original_data.txt'."
    else
        print_result "Enlace Duro" "FAIL" "'hard_link_ref' no es un enlace duro válido para 'original_data.txt'."
    fi
else
    print_result "Enlace Duro" "FAIL" "No se encontró el enlace duro '$CHALLENGE_DIR/hard_link_ref'."
fi

# 3. Validación de Permisos y Propietario de secure_perm.txt
if [ -f "$CHALLENGE_DIR/secure_perm.txt" ]; then
    PERMS="$(stat -c "%a" "$CHALLENGE_DIR/secure_perm.txt" 2>/dev/null | sed 's/^0*//')"
    GROUP="$(stat -c "%G" "$CHALLENGE_DIR/secure_perm.txt" 2>/dev/null)"
    
    # Check numeric or the exact symbolic permissions the student sees with ls -l
    if [ "$PERMS" = "640" ] || ls -l "$CHALLENGE_DIR/secure_perm.txt" 2>/dev/null | grep -q '^-rw-r-----'; then
        print_result "Permisos 640" "SUCCESS" "Los permisos de 'secure_perm.txt' están configurados exactamente a 640."
    else
        print_result "Permisos 640" "FAIL" "Los permisos de 'secure_perm.txt' son '$PERMS' en lugar de '640'."
    fi
    
    if [ "$GROUP" = "vagrant" ]; then
        print_result "Grupo Propietario" "SUCCESS" "El grupo propietario de 'secure_perm.txt' es 'vagrant'."
    else
        print_result "Grupo Propietario" "FAIL" "El grupo es '$GROUP' en lugar de 'vagrant'."
    fi
else
    print_result "Permisos/Propietario" "FAIL" "No se encontró el archivo '$CHALLENGE_DIR/secure_perm.txt'."
fi

# 4. Validación de Filtrado de grep y Redirección
if [ -f "$CHALLENGE_DIR/grep_result.txt" ]; then
    # Compare result with direct grep output from original_data.txt
    diff <(grep -E '^EX200:' "$CHALLENGE_DIR/original_data.txt") "$CHALLENGE_DIR/grep_result.txt" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        print_result "Filtro de Texto grep" "SUCCESS" "'grep_result.txt' contiene exactamente las líneas correctas filtradas."
    else
        print_result "Filtro de Texto grep" "FAIL" "El contenido de 'grep_result.txt' no coincide con el filtro esperado."
    fi
else
    print_result "Filtro de Texto grep" "FAIL" "No se encontró el archivo de salida '$CHALLENGE_DIR/grep_result.txt'."
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
