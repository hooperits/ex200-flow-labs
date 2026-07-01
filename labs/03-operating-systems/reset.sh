#!/bin/bash

# Load common reset helpers
source "/labs/lib/reset-common.sh" 2>/dev/null || true

echo "Restableciendo el entorno del laboratorio de operación del sistema..."

# 1. Stop and disable simple-web service if it exists
if systemctl list-unit-files | grep -q "simple-web.service"; then
    reset_log "Deteniendo y deshabilitando simple-web.service..."
    sudo systemctl stop simple-web.service 2>/dev/null
    sudo systemctl disable simple-web.service 2>/dev/null
    sudo rm -f /etc/systemd/system/simple-web.service
    sudo systemctl daemon-reload
fi

# 2. Restore default target
sudo systemctl set-default multi-user.target &>/dev/null

# 3. Inform user about challenge directory files (student work protection)
if [ -f "$(dirname "$0")/challenge/root_recovery.txt" ]; then
    reset_log "Aviso: El archivo 'challenge/root_recovery.txt' sigue existiendo."
    echo "Si deseas empezar desde cero, bórralo manualmente con: rm $(dirname "$0")/challenge/root_recovery.txt"
fi

reset_log "El entorno del laboratorio ha sido restaurado."
exit 0
