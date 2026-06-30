#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CHALLENGE_DIR="$BASE_DIR/challenge"

echo "Restableciendo el entorno del laboratorio de gestión de paquetes..."

# Limpiar repos creados por el estudiante o demo
rm -f /etc/yum.repos.d/local-test.repo
rm -f /etc/yum.repos.d/my-local.repo
rm -rf /tmp/local-repo /tmp/myrepo

# Remover paquetes instalados en el reto (idempotente)
dnf remove -y httpd 2>/dev/null || true
dnf module remove -y nodejs:18 2>/dev/null || true

# Limpiar challenge si hay archivos
rm -rf "$CHALLENGE_DIR"/*

echo "El entorno del laboratorio ha sido restaurado al estado inicial."
exit 0
