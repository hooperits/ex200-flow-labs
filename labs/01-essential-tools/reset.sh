#!/bin/bash

# Load common reset helpers
source "/labs/lib/reset-common.sh" 2>/dev/null || true

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CHALLENGE_DIR="$BASE_DIR/challenge"

reset_log "Restableciendo el entorno del laboratorio de herramientas esenciales..."

# Idempotent cleanup of challenge artifacts (safe with -f)
safe_remove "$CHALLENGE_DIR/soft_link_ref"
safe_remove "$CHALLENGE_DIR/hard_link_ref"
safe_remove "$CHALLENGE_DIR/secure_perm.txt"
safe_remove "$CHALLENGE_DIR/grep_result.txt"

reset_log "El entorno del laboratorio ha sido restaurado al estado inicial."
exit 0
