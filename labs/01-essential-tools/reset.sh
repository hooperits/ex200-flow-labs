#!/bin/bash

# Determine script base directory dynamically
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CHALLENGE_DIR="$BASE_DIR/challenge"

echo "Restableciendo el entorno del laboratorio de herramientas esenciales..."

# Delete user-created files safely using -f
rm -f "$CHALLENGE_DIR/soft_link_ref"
rm -f "$CHALLENGE_DIR/hard_link_ref"
rm -f "$CHALLENGE_DIR/secure_perm.txt"
rm -f "$CHALLENGE_DIR/grep_result.txt"

echo "El entorno del laboratorio ha sido restaurado al estado inicial."
exit 0
