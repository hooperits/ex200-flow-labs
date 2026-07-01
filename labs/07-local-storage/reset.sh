#!/bin/bash

# Load common reset helpers
source "/labs/lib/reset-common.sh" 2>/dev/null || true

echo "Restableciendo el entorno del laboratorio de almacenamiento local..."

# 1. Unmount directories
for path in "/mnt/docs" "/mnt/vdo" "/mnt/data"; do
    safe_unmount "$path"
    if [ -d "$path" ]; then
        safe_remove "$path"
    fi
done

# 2. Clean up /etc/fstab entries
if [ -f "/etc/fstab" ]; then
    reset_log "Limpiando entradas de vg_labs en /etc/fstab..."
    sudo sed -i '/vg_labs/d' /etc/fstab
fi

# 3. Clean up LVM configurations
if sudo vgs vg_labs &>/dev/null; then
    reset_log "Removiendo Logical Volumes y Volume Group vg_labs..."
    sudo lvremove -f /dev/vg_labs/vdo_vol 2>/dev/null
    sudo lvremove -f /dev/vg_labs/lv_docs 2>/dev/null
    sudo lvremove -f /dev/vg_labs/lv_data 2>/dev/null
    sudo vgremove -f vg_labs 2>/dev/null
    sudo pvremove -f /dev/sdb 2>/dev/null || true
fi

# 4. Clean challenge
safe_remove "$(cd "$(dirname "$0")" && pwd)/challenge/*"

reset_log "El entorno del laboratorio ha sido restaurado al estado inicial."
exit 0
