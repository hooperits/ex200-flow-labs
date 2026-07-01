#!/bin/bash

# Load common reset helpers
source "/labs/lib/reset-common.sh" 2>/dev/null || true

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CHALLENGE_DIR="$BASE_DIR/challenge"

reset_log "Restableciendo el entorno del laboratorio de gestión de paquetes (RHEL 10)..."

# Limpiar archivos de repos
safe_remove /etc/yum.repos.d/local-test.repo
safe_remove /etc/yum.repos.d/my-local.repo

# Remover paquetes
dnf remove -y httpd 2>/dev/null || true

# Limpiar Flatpak (idempotente)
flatpak uninstall --all -y 2>/dev/null || true
flatpak remote-delete flathub 2>/dev/null || true

# Limpiar módulos (si aplica)
dnf module remove -y nodejs 2>/dev/null || true

# Limpiar directorios de repo local
safe_remove "$CHALLENGE_DIR/local-repo"
safe_remove /tmp/local-repo
safe_remove /tmp/myrepo

# Limpiar challenge
safe_remove "$CHALLENGE_DIR/*"

reset_log "El entorno del laboratorio ha sido restaurado al estado inicial."
exit 0
