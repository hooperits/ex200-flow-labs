#!/bin/bash

# Reset system state for Module 07

echo "Restableciendo el entorno del laboratorio de almacenamiento local..."

# 1. Unmount directories
for path in "/mnt/docs" "/mnt/vdo" "/mnt/data"; do
    if mountpoint -q "$path"; then
        echo "Desmontando $path..."
        sudo umount -f "$path" 2>/dev/null
    fi
    if [ -d "$path" ]; then
        sudo rm -rf "$path"
    fi
done

# 2. Clean up /etc/fstab entries
if [ -f "/etc/fstab" ]; then
    echo "Limpiando entradas de vg_labs en /etc/fstab..."
    sudo sed -i '/vg_labs/d' /etc/fstab
fi

# 3. Clean up LVM configurations
if sudo vgs vg_labs &>/dev/null; then
    echo "Removiendo Logical Volumes y Volume Group vg_labs..."
    sudo lvremove -f /dev/vg_labs/vdo_vol 2>/dev/null
    sudo lvremove -f /dev/vg_labs/lv_docs 2>/dev/null
    sudo lvremove -f /dev/vg_labs/lv_data 2>/dev/null
    sudo vgremove -f vg_labs 2>/dev/null
    sudo pvremove -f /dev/sdb 2>/dev/null
fi

echo "El entorno del laboratorio ha sido restaurado."
exit 0
