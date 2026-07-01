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
            echo -e "    ${YELLOW}SUGGESTION:${NC} Revisa instructions.md. Usa 'dnf repolist', 'flatpak list', 'createrepo' para depurar."
        fi
    fi
}

if $EXPLAIN_MODE; then
    echo -e "${YELLOW}EXPLAIN MODE: Mostrando descripción de cada verificación + sugerencias en fallos.${NC}"
    echo
fi

echo -e "${CYAN}================================================================${NC}"
echo -e "${CYAN}      Evaluador de Reto: Módulo 10 - Gestión de Paquetes (RHEL 10)     ${NC}"
echo -e "${CYAN}================================================================${NC}"
echo

# 1. Validar repo local-test.repo
if [ -f /etc/yum.repos.d/local-test.repo ]; then
    print_result "Archivo Repo local-test" "SUCCESS" "Se encontró /etc/yum.repos.d/local-test.repo"
else
    print_result "Archivo Repo local-test" "FAIL" "No se encontró /etc/yum.repos.d/local-test.repo"
fi

# 2. Validar instalación de httpd
if rpm -q httpd &>/dev/null; then
    print_result "Paquete httpd instalado" "SUCCESS" "httpd está instalado."
else
    print_result "Paquete httpd instalado" "FAIL" "httpd no está instalado (o fue removido)."
fi

# 3. Validar Flatpak instalado y con remote
if command -v flatpak &>/dev/null && flatpak remote-list | grep -q flathub; then
    print_result "Flatpak + Flathub" "SUCCESS" "flatpak instalado y Flathub agregado."
else
    print_result "Flatpak + Flathub" "FAIL" "flatpak no está instalado o falta Flathub."
fi

# 4. Validar al menos una app de Flatpak instalada
if flatpak list &>/dev/null && [ "$(flatpak list | wc -l)" -gt 0 ]; then
    print_result "Aplicación Flatpak instalada" "SUCCESS" "Se detectó al menos una app Flatpak."
else
    print_result "Aplicación Flatpak instalada" "FAIL" "No se detectó ninguna aplicación Flatpak instalada."
fi

# 5. Validar módulo habilitado
if dnf module list --enabled 2>/dev/null | grep -qE 'nodejs|python|httpd'; then
    print_result "Módulo DNF habilitado" "SUCCESS" "Al menos un módulo aparece habilitado."
else
    print_result "Módulo DNF habilitado" "FAIL" "No se detectó módulo habilitado."
fi

# 6. Validar repo local en challenge/
if [ -d "$CHALLENGE_DIR/local-repo" ] && [ -f "$CHALLENGE_DIR/local-repo/repodata/repomd.xml" ]; then
    print_result "Repositorio Local creado" "SUCCESS" "Se encontró challenge/local-repo con metadatos."
else
    print_result "Repositorio Local creado" "FAIL" "No se encontró repo local con repodata en challenge/."
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
