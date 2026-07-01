#!/bin/bash

# Load common reset helpers
source "/labs/lib/reset-common.sh" 2>/dev/null || true

echo "Restableciendo el entorno del laboratorio de redes y cron..."

# 1. Restore hostname to localhost
sudo hostnamectl set-hostname localhost &>/dev/null

# 2. Reset network connections (remove static IP configurations and return to DHCP)
# Find connections containing static IP and remove them or reset back to dhcp
# Typically, eth1 is configured manually. Let's find any connection on eth1 and set back to auto.
# We'll search for active connection on eth1 or similar
CONN_NAME=$(nmcli -t -f DEVICE,NAME connection show --active | grep -E "^(eth1|enp0s8|enp0s9):" | cut -d: -f2 | head -n 1)

if [ -n "$CONN_NAME" ]; then
    reset_log "Restaurando conexión '$CONN_NAME' a DHCP..."
    sudo nmcli connection modify "$CONN_NAME" ipv4.addresses "" ipv4.gateway "" ipv4.dns "" ipv4.method auto &>/dev/null
    sudo nmcli connection up "$CONN_NAME" &>/dev/null
fi

reset_log "El entorno del laboratorio ha sido restaurado."
exit 0

# 3. Restore chrony.conf by removing pool.ntp.org line
if [ -f "/etc/chrony.conf" ]; then
    echo "Removiendo pool.ntp.org de /etc/chrony.conf..."
    sudo sed -i '/pool.ntp.org/d' /etc/chrony.conf
    sudo sed -i '/pool.ntp.org/d' /etc/chrony.conf
    sudo systemctl restart chronyd &>/dev/null
fi

# 4. Remove vagrant's crontab tasks
echo "Eliminando tareas crontab del usuario vagrant..."
sudo crontab -u vagrant -r 2>/dev/null

# 5. Remove any generated log files
rm -f /tmp/cron_test.txt

echo "El entorno del laboratorio ha sido restaurado."
exit 0
