#!/bin/bash

# ANSI colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CHALLENGE_DIR="$BASE_DIR/challenge"
RECOVERY_FILE="$CHALLENGE_DIR/root_recovery.txt"

FAILED_TESTS=0

print_result() {
    local test_name="$1"
    local status="$2"
    local message="$3"
    
    if [ "$status" = "SUCCESS" ]; then
        echo -e "[ ${GREEN}PASSED${NC} ] $test_name - $message"
    else
        echo -e "[ ${RED}FAILED${NC} ] $test_name - $message"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
}

echo -e "${CYAN}================================================================${NC}"
echo -e "${CYAN}         Evaluador de Reto: Módulo 03 - Operación del Sistema   ${NC}"
echo -e "${CYAN}================================================================${NC}"
echo

# 1. Validar que el archivo de servicio systemd exista
SERVICE_FILE="/etc/systemd/system/simple-web.service"
if [ -f "$SERVICE_FILE" ]; then
    print_result "Archivo de Servicio systemd" "SUCCESS" "Se encontró el archivo '$SERVICE_FILE'."
else
    print_result "Archivo de Servicio systemd" "FAIL" "No se encontró el archivo '$SERVICE_FILE' en /etc/systemd/system/."
fi

# 2. Validar que el servicio esté habilitado (enabled)
if systemctl is-enabled simple-web.service &>/dev/null; then
    print_result "Servicio Habilitado (Enabled)" "SUCCESS" "El servicio simple-web.service está habilitado para el arranque."
else
    print_result "Servicio Habilitado (Enabled)" "FAIL" "El servicio simple-web.service no está habilitado (systemctl enable)."
fi

# 3. Validar que el servicio esté activo (running)
if systemctl is-active simple-web.service &>/dev/null; then
    print_result "Servicio Activo (Running)" "SUCCESS" "El servicio simple-web.service está activo y corriendo."
else
    print_result "Servicio Activo (Running)" "FAIL" "El servicio simple-web.service no está activo (systemctl start)."
fi

# 4. Validar el Target Predeterminado
DEFAULT_TARGET=$(systemctl get-default)
if [ "$DEFAULT_TARGET" = "multi-user.target" ]; then
    print_result "Target Predeterminado" "SUCCESS" "El target por defecto es 'multi-user.target'."
else
    print_result "Target Predeterminado" "FAIL" "El target por defecto es '$DEFAULT_TARGET' en vez de 'multi-user.target'."
fi

# 5. Validar el archivo root_recovery.txt
if [ -f "$RECOVERY_FILE" ]; then
    CONTENT=$(cat "$RECOVERY_FILE")
    
    # Comprobar palabras clave obligatorias
    MISSING_KEYS=()
    for key in "rd.break" "remount,rw" "sysroot" "chroot" "passwd" "autorelabel"; do
        if ! echo "$CONTENT" | grep -qi "$key"; then
            MISSING_KEYS+=("$key")
        fi
    done
    
    if [ ${#MISSING_KEYS[@]} -eq 0 ]; then
        print_result "Secuencia de Recuperación de root" "SUCCESS" "El documento contiene toda la secuencia de GRUB correcta."
    else
        print_result "Secuencia de Recuperación de root" "FAIL" "Faltan las siguientes palabras clave en el documento: [${MISSING_KEYS[*]}]."
    fi
else
    print_result "Secuencia de Recuperación de root" "FAIL" "No se encontró el archivo '$RECOVERY_FILE'."
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
