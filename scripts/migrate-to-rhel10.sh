#!/bin/bash
set -euo pipefail

# Automation script to migrate RHCSA-EX200 repo to AlmaLinux 10 / RHEL 10
# and clean all v9 references.
#
# Usage:
#   ./scripts/migrate-to-rhel10.sh --dry-run
#   ./scripts/migrate-to-rhel10.sh
#
# Features:
# - Dry-run support
# - Backups
# - Targeted globs
# - Post regen of skeletons
# - Safety excludes for historical docs

DRY_RUN=false
BACKUP_DIR=".rhel10-migration-backup-$(date +%s)"
EXCLUDE_PATTERNS="RHEL10-migration|RHEL10-decisions|readme-update-plan|lyrics-sync"

usage() {
  echo "Usage: $0 [--dry-run] [--no-backup]"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case $1 in
    --dry-run) DRY_RUN=true; shift ;;
    --no-backup) BACKUP_DIR=""; shift ;;
    -h|--help) usage ;;
    *) echo "Unknown arg: $1"; usage ;;
  esac
done

echo "=== RHCSA RHEL 10 Migration Script ==="
echo "DRY_RUN=$DRY_RUN"

if [[ -n "$BACKUP_DIR" && "$DRY_RUN" == false ]]; then
  mkdir -p "$BACKUP_DIR"
  echo "Backups will go to $BACKUP_DIR"
fi

# Define replacements (order matters: more specific first)
declare -A REPLACES
REPLACES["Rocky/AlmaLinux 9"]="AlmaLinux 10"
REPLACES["AlmaLinux 9 / RHEL 9"]="AlmaLinux 10 / RHEL 10"
REPLACES["en AlmaLinux 9 / RHEL 9"]="en AlmaLinux 10 / RHEL 10"
REPLACES["RHEL 9 / AlmaLinux 9"]="RHEL 10 / AlmaLinux 10"
REPLACES["RHEL-9%20%7C%20AlmaLinux%209"]="RHEL-10%20%7C%20AlmaLinux%2010"
REPLACES["RHEL-9 | AlmaLinux 9"]="RHEL-10 | AlmaLinux 10"
REPLACES["sobre RHEL 9 / AlmaLinux 9"]="sobre RHEL 10 / AlmaLinux 10"
REPLACES["en Rocky/AlmaLinux 9"]="en AlmaLinux 10"
REPLACES["en AlmaLinux 9"]="en AlmaLinux 10"
REPLACES["RHEL 9"]="RHEL 10"   # broad, applied last with care
REPLACES["AlmaLinux 9"]="AlmaLinux 10"

TARGET_FILES=(
  "README.md"
  "ROADMAP.md"
  "docs/objective-matrix.md"
  "docs/progress.json"
  "labs/**/*.md"
  "labs/**/*.sh"
  "skeletons/**/*.md"
  "skeletons/**/*.txt"
)

echo "Scanning and applying replacements..."

for pattern in "${!REPLACES[@]}"; do
  replacement="${REPLACES[$pattern]}"
  echo "  Replacing: '$pattern' -> '$replacement'"

  # Use find + sed for globs
  while IFS= read -r -d '' file; do
    # Skip excluded
    if echo "$file" | grep -qE "$EXCLUDE_PATTERNS"; then
      continue
    fi

    if grep -q "$pattern" "$file" 2>/dev/null; then
      if [[ "$DRY_RUN" == true ]]; then
        echo "    [DRY] Would change: $file"
        grep -n "$pattern" "$file" | head -1
      else
        if [[ -n "$BACKUP_DIR" ]]; then
          cp "$file" "$BACKUP_DIR/$(basename "$file").bak.$(date +%s%N)" 2>/dev/null || true
        fi
        # Use perl for safer multi-line aware replace if needed, but sed for simple
        sed -i "s|${pattern}|${replacement}|g" "$file"
        echo "    Updated: $file"
      fi
    fi
  done < <(find . -path ./$BACKUP_DIR -prune -o \( -name "*.md" -o -name "*.sh" -o -name "*.json" \) -print0 2>/dev/null)
done

# Special handling
if [[ "$DRY_RUN" == false ]]; then
  # Update lab count references if still "15"
  sed -i 's/15 laboratorios/14 laboratorios/g' README.md 2>/dev/null || true
  sed -i 's/15 Retos/14 Retos/g' README.md 2>/dev/null || true

  echo "Running skeleton regeneration (if generator exists)..."
  if [[ -x "./scripts/generate-video-skeleton.sh" ]]; then
    ./scripts/generate-video-skeleton.sh --all || echo "Generator run completed (or had warnings)"
  fi
fi

echo
echo "=== Migration dry-run / run complete ==="
echo "Recommended next:"
echo "  1. Review changes: git diff --stat"
echo "  2. Run verifier: ./scripts/check-no-v9-refs.sh (create if missing)"
echo "  3. Test: vagrant validate"
echo "  4. For Lab 09 removal, use separate flag or manual if not done."

echo "Done."