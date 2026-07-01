#!/bin/bash
# Quick checker for leftover RHEL 9 / AlmaLinux 9 references after migration.
# Excludes migration docs and Lab 09 (if removal in progress).

set -euo pipefail

echo "=== Checking for remaining v9 references ==="

PATTERN='RHEL 9|AlmaLinux 9|rocky.*9|ubi9|Rocky Linux 9|RHEL-9'

# Run grep, exclude known safe files
RESULTS=$(grep -r -n -E "$PATTERN" . \
  --include="*.md" --include="*.sh" --include="*.txt" --include="*.json" \
  --exclude-dir=.git \
  | grep -v -E "(RHEL10-migration|RHEL10-decisions|readme-update-plan|lyrics-sync-process|plan.md|09-podman-containers|historical|ROADMAP historical|decisions.md)" \
  || true)

if [[ -z "$RESULTS" ]]; then
  echo "✅ No leftover v9 references found (outside excluded historical/lab09 paths)."
  exit 0
else
  echo "❌ Found leftover references:"
  echo "$RESULTS"
  echo
  echo "Review and clean remaining items, or update excludes if intentional."
  exit 1
fi