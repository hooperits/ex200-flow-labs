#!/bin/bash

# ANSI colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

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
echo -e "${CYAN}         Evaluador de Reto: Módulo 04 - Usuarios y Grupos       ${NC}"
echo -e "${CYAN}================================================================${NC}"
echo

# 1. Verificar si el grupo 'sysadmin' existe
if getent group sysadmin &>/dev/null; then
    print_result "Grupo 'sysadmin'" "SUCCESS" "El grupo 'sysadmin' existe en el sistema."
else
    print_result "Grupo 'sysadmin'" "FAIL" "El grupo 'sysadmin' no ha sido creado."
fi

# 2. Verificar si el usuario 'operator1' existe, tiene shell /sbin/nologin y pertenece a sysadmin
if id operator1 &>/dev/null; then
    SHELL_OP=$(getent passwd operator1 | cut -d: -f7)
    IN_GRP=$(id -nG operator1 | grep -w "sysadmin")
    
    if [ "$SHELL_OP" = "/sbin/nologin" ] && [ -n "$IN_GRP" ]; then
        print_result "Usuario 'operator1'" "SUCCESS" "operator1 existe con shell /sbin/nologin y pertenece al grupo sysadmin."
    else
        print_result "Usuario 'operator1'" "FAIL" "operator1 existe pero shell es '$SHELL_OP' (debe ser /sbin/nologin) o no pertenece a sysadmin."
    fi
else
    print_result "Usuario 'operator1'" "FAIL" "El usuario 'operator1' no ha sido creado."
fi

# 3. Verificar si el usuario 'auditor1' existe
if id auditor1 &>/dev/null; then
    print_result "Usuario 'auditor1'" "SUCCESS" "El usuario 'auditor1' existe."
else
    print_result "Usuario 'auditor1'" "FAIL" "El usuario 'auditor1' no ha sido creado."
fi

# 4. Verificar directorio /srv/sysadmin_docs y permisos SGID
DIR="/srv/sysadmin_docs"
if [ -d "$DIR" ]; then
    GROUP_OWNER=$(stat -c "%G" "$DIR")
    PERM=$(stat -c "%a" "$DIR") # Esperado: 2770
    
    # Comprobar SGID bit
    if [ "$GROUP_OWNER" = "sysadmin" ] && [ "${PERM:0:1}" = "2" ]; then
        print_result "Directorio Compartido y SGID" "SUCCESS" "El directorio existe, pertenece a sysadmin y tiene SGID (2770)."
    else
        print_result "Directorio Compartido y SGID" "FAIL" "El directorio pertenece a '$GROUP_OWNER' (esperado: sysadmin) o permisos son '$PERM' (esperado: 2770)."
    fi
else
    print_result "Directorio Compartido y SGID" "FAIL" "El directorio '$DIR' no existe."
fi

# 5. Verificar ACLs para auditor1
if [ -d "$DIR" ]; then
    ACL_CHECK=$(getfacl -p "$DIR" 2>/dev/null | grep "user:auditor1:r-x")
    
    if [ -n "$ACL_CHECK" ]; then
        print_result "Listas de Control de Acceso (ACL)" "SUCCESS" "auditor1 tiene ACLs de lectura y ejecución en el directorio."
    else
        print_result "Listas de Control de Acceso (ACL)" "FAIL" "No se encontró una ACL de tipo 'user:auditor1:r-x' en el directorio."
    fi
else
    print_result "Listas de Control de Acceso (ACL)" "FAIL" "No se puede verificar ACLs porque el directorio no existe."
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
