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
echo -e "${CYAN}         Evaluador de Reto: Módulo 05 - Redes y Cron            ${NC}"
echo -e "${CYAN}================================================================${NC}"
echo

# 1. Verificar Hostname
HOST_NAME=$(hostname)
if [[ "$HOST_NAME" == "rhcsa-server" ]]; then
    print_result "Hostname del Sistema" "SUCCESS" "El hostname está configurado como 'rhcsa-server'."
else
    print_result "Hostname del Sistema" "FAIL" "El hostname actual es '$HOST_NAME' (esperado: 'rhcsa-server')."
fi

# 2. Verificar IP Estática
# Comprobamos si la IP 192.168.56.20 está asignada en alguna interfaz de red
IP_CHECK=$(ip addr show | grep "192.168.56.20")
if [ -n "$IP_CHECK" ]; then
    print_result "Dirección IP Estática" "SUCCESS" "La IP 192.168.56.20 está asignada correctamente a una interfaz."
else
    print_result "Dirección IP Estática" "FAIL" "No se encontró ninguna interfaz de red con la IP 192.168.56.20."
fi

# 3. Verificar Servidor NTP en chrony.conf
CHRONY_CONF="/etc/chrony.conf"
if [ -f "$CHRONY_CONF" ]; then
    NTP_CHECK=$(grep -v "^#" "$CHRONY_CONF" | grep "pool.ntp.org")
    if [ -n "$NTP_CHECK" ]; then
        print_result "Servidor NTP (Chrony)" "SUCCESS" "Se encontró 'pool.ntp.org' configurado en /etc/chrony.conf."
    else
        print_result "Servidor NTP (Chrony)" "FAIL" "No se encontró el servidor 'pool.ntp.org' en /etc/chrony.conf."
    fi
else
    print_result "Servidor NTP (Chrony)" "FAIL" "No se encontró el archivo de configuración /etc/chrony.conf."
fi

# 4. Verificar Tarea Cron para el usuario vagrant
# Comprobamos las tareas crontab del usuario vagrant
# En RHEL, podemos comprobar con crontab -u vagrant -l o revisando la carpeta /var/spool/cron/vagrant
CRON_CHECK=$(sudo crontab -u vagrant -l 2>/dev/null | grep -v "^#" | grep "0 3 \* \* 1")
CRON_CMD_CHECK=$(sudo crontab -u vagrant -l 2>/dev/null | grep -v "^#" | grep "cron_test.txt")

if [ -n "$CRON_CHECK" ] && [ -n "$CRON_CMD_CHECK" ]; then
    print_result "Programación Tareas (Cron)" "SUCCESS" "La tarea cron está programada correctamente para los lunes a las 3:00 AM."
else
    print_result "Programación Tareas (Cron)" "FAIL" "La tarea cron no está configurada o no tiene los parámetros/comando esperados."
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
