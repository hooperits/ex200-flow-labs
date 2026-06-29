#!/bin/bash

# Reset system state for Module 08

echo "Restableciendo el entorno del laboratorio de montajes y autofs..."

# 1. Unmount directories
for path in "/shares/nfs_share" "/mnt/data_local"; do
    if mountpoint -q "$path"; then
        echo "Desmontando $path..."
        sudo umount -f "$path" 2>/dev/null
    fi
done

# 2. Stop and disable autofs
if systemctl list-unit-files | grep -q "autofs.service"; then
    echo "Deteniendo y deshabilitando autofs..."
    sudo systemctl stop autofs &>/dev/null
    sudo systemctl disable autofs &>/dev/null
fi

# 3. Restore configurations
if [ -f "/etc/fstab" ]; then
    echo "Limpiando entradas de data_local en /etc/fstab..."
    sudo sed -i '/data_local/d' /etc/fstab
fi

if [ -f "/etc/auto.master" ]; then
    echo "Removiendo línea de /shares de /etc/auto.master..."
    sudo sed -i '/\/shares/d' /etc/auto.master
fi

# 4. Remove temporary map files and mount points
sudo rm -f /etc/auto.shares
sudo rm -rf /shares
sudo rm -rf /mnt/data_local

echo "El entorno del laboratorio ha sido restaurado."
exit 0
