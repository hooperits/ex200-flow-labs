#!/bin/bash

# Load common reset helpers
source "$(cd "$(dirname "$0")" && pwd)/../../lib/reset-common.sh" 2>/dev/null || true

echo "Restableciendo el entorno del laboratorio de seguridad y SELinux..."

# 1. Clean up firewall rules if firewall-cmd is available
if command -v firewall-cmd &>/dev/null; then
    reset_log "Removiendo reglas permanentes del firewall..."
    sudo firewall-cmd --permanent --zone=public --remove-service=http &>/dev/null
    sudo firewall-cmd --permanent --zone=public --remove-port=82/tcp &>/dev/null
    sudo firewall-cmd --reload &>/dev/null
fi

# 2. Clean up directory
if [ -d "/var/www/custom_html" ]; then
    reset_log "Eliminando directorio /var/www/custom_html..."
    sudo rm -rf /var/www/custom_html
fi

reset_log "El entorno del laboratorio ha sido restaurado."
exit 0

# 3. Clean up SELinux fcontext registration if semanage is available
if command -v semanage &>/dev/null; then
    echo "Removiendo regla de contexto semanage..."
    sudo semanage fcontext -d "/var/www/custom_html(/.*)?" &>/dev/null
fi

# 4. Clean up SELinux boolean if setsebool is available
if command -v setsebool &>/dev/null; then
    echo "Restableciendo booleano httpd_enable_homedirs a off..."
    sudo setsebool -P httpd_enable_homedirs off &>/dev/null
fi

echo "El entorno del laboratorio ha sido restaurado."
exit 0
