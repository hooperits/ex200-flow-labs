#!/bin/bash
# lib/reset-common.sh
# Common helpers for reset.sh scripts across labs.
# Provides consistent logging, safe cleanup, etc.

# Colors (if not already)
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

reset_log() {
    echo -e "${CYAN}[RESET]${NC} $1"
}

safe_remove() {
    local path="$1"
    if [ -e "$path" ]; then
        reset_log "Removing $path"
        rm -rf "$path" 2>/dev/null || sudo rm -rf "$path"
    fi
}

safe_unmount() {
    local path="$1"
    if mountpoint -q "$path"; then
        reset_log "Unmounting $path"
        sudo umount -f "$path" 2>/dev/null || true
    fi
}

echo "Loaded reset-common.sh helpers"
