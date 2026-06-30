#!/bin/bash

# Load common reset helpers
source "$(cd "$(dirname "$0")" && pwd)/../../lib/reset-common.sh" 2>/dev/null || true

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CHALLENGE_DIR="$BASE_DIR/challenge"

reset_log "Restableciendo el entorno del laboratorio de gestión de paquetes..."

# Limpiar repos
safe_remove /etc/yum.repos.d/local-test.repo
safe_remove /etc/yum.repos.d/my-local.repo
safe_remove /tmp/local-repo
safe_remove /tmp/myrepo

# Remover paquetes (idempotente)
dnf remove -y httpd 2>/dev/null || true
dnf module remove -y nodejs:18 2>/dev/null || true

# Limpiar challenge
safe_remove "$CHALLENGE_DIR/*"

reset_log "El entorno del laboratorio ha sido restaurado al estado inicial."
exit 0
