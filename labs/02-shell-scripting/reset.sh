#!/bin/bash

# Load common reset helpers
source "$(cd "$(dirname "$0")" && pwd)/../../lib/reset-common.sh" 2>/dev/null || true

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CHALLENGE_DIR="$BASE_DIR/challenge"

reset_log "Restableciendo el entorno del laboratorio de shell scripting..."

# Clean up dynamic test directories safely using rm -rf
safe_remove "$CHALLENGE_DIR/test_dir"

# Do not delete the student script file_filter.sh automatically to prevent loss of work,
# but print instructions if it exists.
if [ -f "$CHALLENGE_DIR/file_filter.sh" ]; then
    reset_log "Aviso: El script 'challenge/file_filter.sh' del estudiante sigue existiendo."
    echo "Si deseas empezar desde cero, bórralo manualmente con: rm $CHALLENGE_DIR/file_filter.sh"
fi

reset_log "El entorno del laboratorio ha sido restaurado."
exit 0
