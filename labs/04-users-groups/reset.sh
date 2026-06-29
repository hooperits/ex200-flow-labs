#!/bin/bash

# Reset system state for Module 04

echo "Restableciendo el entorno del laboratorio de usuarios y grupos..."

# 1. Delete users if they exist using userdel
for user in "operator1" "auditor1"; do
    if id "$user" &>/dev/null; then
        echo "Eliminando usuario $user..."
        sudo userdel -r "$user" 2>/dev/null || sudo userdel -f "$user" 2>/dev/null
    fi
done

# 2. Delete group if it exists
if getent group sysadmin &>/dev/null; then
    echo "Eliminando grupo sysadmin..."
    sudo groupdel sysadmin 2>/dev/null
fi

# 3. Delete directory
if [ -d "/srv/sysadmin_docs" ]; then
    echo "Eliminando directorio /srv/sysadmin_docs..."
    sudo rm -rf /srv/sysadmin_docs
fi

echo "El entorno del laboratorio ha sido restaurado."
exit 0
