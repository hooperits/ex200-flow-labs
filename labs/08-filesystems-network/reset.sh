#!/bin/bash

# Load common reset helpers
source "/labs/lib/reset-common.sh" 2>/dev/null || true

echo "Restableciendo el entorno del laboratorio de montajes y autofs..."

# 1. Unmount directories
for path in "/shares/nfs_share" "/mnt/data_local"; do
    safe_unmount "$path"
done

# 2. Stop and disable autofs
if systemctl list-unit-files | grep -q "autofs.service"; then
    reset_log "Deteniendo y deshabilitando autofs..."
    sudo systemctl stop autofs &>/dev/null
    sudo systemctl disable autofs &>/dev/null
fi

# 3. Restore configurations
if [ -f "/etc/fstab" ]; then
    reset_log "Limpiando entradas de data_local en /etc/fstab..."
    sudo sed -i '/data_local/d' /etc/fstab
fi

if [ -f "/etc/auto.master" ]; then
    reset_log "Removiendo línea de /shares de /etc/auto.master..."
    sudo sed -i '/\/shares/d' /etc/auto.master
fi

# 4. Remove temporary map files and mount points
safe_remove /etc/auto.shares
safe_remove /shares
safe_remove /mnt/data_local

reset_log "El entorno del laboratorio ha sido restaurado."
exit 0
