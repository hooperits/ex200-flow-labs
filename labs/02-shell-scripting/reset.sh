#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CHALLENGE_DIR="$BASE_DIR/challenge"

echo "Restableciendo el entorno del laboratorio de shell scripting..."

# Clean up dynamic test directories safely using rm -rf
rm -rf "$CHALLENGE_DIR/test_dir"

# Do not delete the student script file_filter.sh automatically to prevent loss of work,
# but print instructions if it exists.
if [ -f "$CHALLENGE_DIR/file_filter.sh" ]; then
    echo "Aviso: El script 'challenge/file_filter.sh' del estudiante sigue existiendo."
    echo "Si deseas empezar desde cero, bórralo manualmente con: rm $CHALLENGE_DIR/file_filter.sh"
fi

echo "El entorno del laboratorio ha sido restaurado."
exit 0
