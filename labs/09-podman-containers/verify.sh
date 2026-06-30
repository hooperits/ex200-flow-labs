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
            echo -e "    ${YELLOW}SUGGESTION:${NC} Revisa instructions.md. Usa 'podman', 'systemctl --user', 'loginctl', 'getfacl' para depurar containers y linger."
        fi
    fi
}

if $EXPLAIN_MODE; then
    echo -e "${YELLOW}EXPLAIN MODE: Mostrando descripción de cada verificación + sugerencias en fallos.${NC}"
    echo
fi

echo -e "${CYAN}================================================================${NC}"
echo -e "${CYAN}         Evaluador de Reto: Módulo 09 - Contenedores Podman     ${NC}"
echo -e "${CYAN}================================================================${NC}"
echo

# 1. Verificar si el contenedor web-server está configurado y existe en Podman
if command -v podman &>/dev/null; then
    CONTAINER_CHECK=$(podman ps -a --filter name=web-server --format "{{.Names}}")
    if [ "$CONTAINER_CHECK" = "web-server" ]; then
        print_result "Contenedor Podman web-server" "SUCCESS" "Se encontró el contenedor web-server configurado."
    else
        print_result "Contenedor Podman web-server" "FAIL" "No se encontró el contenedor con el nombre 'web-server'."
    fi
else
    print_result "Contenedor Podman web-server" "FAIL" "El comando podman no está disponible en este sistema."
fi

# 2. Verificar existencia del directorio de volumen montado
VOL_DIR="/home/vagrant/html"
if [ -d "$VOL_DIR" ]; then
    print_result "Directorio de Volumen del Host" "SUCCESS" "El directorio /home/vagrant/html existe."
else
    print_result "Directorio de Volumen del Host" "FAIL" "No existe el directorio de volumen /home/vagrant/html."
fi

# 3. Verificar que el archivo de servicio systemd de usuario exista y esté habilitado
# Nota: La ruta por defecto de systemd de usuario es ~/.config/systemd/user/
USER_SERVICE_DIR="/home/vagrant/.config/systemd/user"
SERVICE_FILE="$USER_SERVICE_DIR/container-web-server.service"

if [ -f "$SERVICE_FILE" ]; then
    # Verificar si está habilitada (si existe el enlace simbólico en ~/.config/systemd/user/default.target.wants/ o similar)
    ENABLED_CHECK=$(find "$USER_SERVICE_DIR" -name "container-web-server.service" | grep -v "/default.target.wants/" | head -n 1)
    if [ -n "$ENABLED_CHECK" ]; then
        print_result "Servicio systemd de Usuario" "SUCCESS" "El archivo de servicio de systemd existe y está registrado."
    else
        print_result "Servicio systemd de Usuario" "FAIL" "El archivo de servicio de systemd existe pero no se ha habilitado correctamente."
    fi
else
    print_result "Servicio systemd de Usuario" "FAIL" "No se encontró el archivo de servicio '$SERVICE_FILE'."
fi

# 4. Verificar linger habilitado para el usuario vagrant
# Comprobamos la existencia del archivo de persistencia linger
LINGER_FILE="/var/lib/systemd/linger/vagrant"
if [ -f "$LINGER_FILE" ]; then
    print_result "Persistencia de Sesión (Linger)" "SUCCESS" "Linger está habilitado correctamente para el usuario vagrant."
else
    # Comprobar alternativamente usando loginctl
    if command -v loginctl &>/dev/null; then
        LINGER_CHECK=$(loginctl show-user vagrant 2>/dev/null | grep -i "Linger=yes")
        if [ -n "$LINGER_CHECK" ]; then
            print_result "Persistencia de Sesión (Linger)" "SUCCESS" "Linger está habilitado para vagrant."
        else
            print_result "Persistencia de Sesión (Linger)" "FAIL" "Linger no está habilitado para vagrant."
        fi
    else
        print_result "Persistencia de Sesión (Linger)" "FAIL" "Linger no está habilitado."
    fi
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
