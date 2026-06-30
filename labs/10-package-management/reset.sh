#!/bin/bash

# Determine script base directory dynamically
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CHALLENGE_DIR="$BASE_DIR/challenge"

echo "Restableciendo el entorno del laboratorio de herramientas esenciales..."

# Idempotent cleanup of challenge artifacts (safe with -f)
rm -f "$CHALLENGE_DIR/soft_link_ref" \
      "$CHALLENGE_DIR/hard_link_ref" \
      "$CHALLENGE_DIR/secure_perm.txt" \
      "$CHALLENGE_DIR/grep_result.txt"

# Future: source lib/reset-common.sh when implemented for shared patterns
# (e.g., common logging, safe removal helpers)

echo "El entorno del laboratorio ha sido restaurado al estado inicial."
exit 0
