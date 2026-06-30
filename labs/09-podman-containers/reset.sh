#!/bin/bash

# Load common reset helpers
source "$(cd "$(dirname "$0")" && pwd)/../../lib/reset-common.sh" 2>/dev/null || true

echo "Restableciendo el entorno del laboratorio de contenedores Podman..."

# 1. Stop and disable systemd user service if it exists
# We do this as the user running the script
if [ -d "/home/vagrant/.config/systemd/user" ]; then
    reset_log "Deteniendo y deshabilitando el servicio de systemd del usuario..."
    systemctl --user stop container-web-server.service &>/dev/null
    systemctl --user disable container-web-server.service &>/dev/null
    rm -rf /home/vagrant/.config/systemd/user/container-web-server.service
    systemctl --user daemon-reload &>/dev/null
fi

# 2. Stop and remove container if it exists
if command -v podman &>/dev/null; then
    if podman ps -a --filter name=web-server --format "{{.Names}}" | grep -q "web-server"; then
        reset_log "Deteniendo y eliminando contenedor web-server..."
        podman stop -t 1 web-server &>/dev/null
        podman rm -f web-server &>/dev/null
    fi
fi

# 3. Disable linger using loginctl
if command -v loginctl &>/dev/null; then
    reset_log "Deshabilitando linger..."
    sudo loginctl disable-linger vagrant &>/dev/null
fi

reset_log "El entorno del laboratorio ha sido restaurado."
exit 0

# 4. Remove mount folder
if [ -d "/home/vagrant/html" ]; then
    echo "Eliminando directorio /home/vagrant/html..."
    rm -rf /home/vagrant/html
fi

echo "El entorno del laboratorio ha sido restaurado."
exit 0
