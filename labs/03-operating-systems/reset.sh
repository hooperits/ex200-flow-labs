#!/bin/bash

# Reset system state for Module 03

echo "Restableciendo el entorno del laboratorio de operación del sistema..."

# 1. Stop and disable simple-web service if it exists
if systemctl list-unit-files | grep -q "simple-web.service"; then
    echo "Deteniendo y deshabilitando simple-web.service..."
    sudo systemctl stop simple-web.service 2>/dev/null
    sudo systemctl disable simple-web.service 2>/dev/null
    sudo rm -f /etc/systemd/system/simple-web.service
    sudo systemctl daemon-reload
fi

# 2. Restore default target to graphical.target (since host usually has graphic capabilities or we want default)
# (Vagrant AlmaLinux defaults to multi-user, but we can set it back to multi-user or just ignore target change)
# Let's set it back to multi-user.target to be safe since that is server default.
sudo systemctl set-default multi-user.target &>/dev/null

# 3. Inform user about challenge directory files
if [ -f "$(dirname "$0")/challenge/root_recovery.txt" ]; then
    echo "Aviso: El archivo 'challenge/root_recovery.txt' sigue existiendo."
    echo "Si deseas empezar desde cero, bórralo manualmente con: rm $(dirname "$0")/challenge/root_recovery.txt"
fi

echo "El entorno del laboratorio ha sido restaurado."
exit 0
