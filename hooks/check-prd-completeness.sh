#!/bin/bash
# =============================================================================
# Claude Code Hook: PRD Completeness Checker
# =============================================================================
# Stop hook — runs after Claude finishes responding. Checks if PRD-pattern
# files were written/edited. If so, verifies required sections are present.
# =============================================================================

set -euo pipefail

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
PRD_NAME_PATTERNS=(
    'PRD'
    'prd'
    'Requirements'
    'requirements'
    'Product'
    'product'
)

REQUIRED_SECTIONS=(
    "Problem Statement"
    "Goals"
    "User Stories"
    "Success Metrics"
)

# -----------------------------------------------------------------------------
# Read hook input from stdin
# -----------------------------------------------------------------------------
INPUT=$(cat)
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // empty')
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')

if [ -z "$TRANSCRIPT_PATH" ] || [ ! -f "$TRANSCRIPT_PATH" ]; then
    exit 0
fi

# -----------------------------------------------------------------------------
# Find .md files written or edited in this session
# -----------------------------------------------------------------------------
MODIFIED_FILES=$(grep -oE '"tool"\s*:\s*"(Write|Edit)"[^}]*"file_path"\s*:\s*"[^"]*"' "$TRANSCRIPT_PATH" 2>/dev/null | \
    grep -oE '"file_path"\s*:\s*"[^"]*"' | \
    sed 's/"file_path"\s*:\s*"//;s/"$//' | \
    sort -u || true)

if [ -z "$MODIFIED_FILES" ]; then
    exit 0
fi

# -----------------------------------------------------------------------------
# Filter for PRD-pattern markdown files
# -----------------------------------------------------------------------------
PRD_FILES=""
while IFS= read -r file; do
    [ -z "$file" ] && continue
    if ! echo "$file" | grep -qE '\.md$'; then
        continue
    fi
    BASENAME=$(basename "$file")
    for pattern in "${PRD_NAME_PATTERNS[@]}"; do
        if echo "$BASENAME" | grep -q "$pattern"; then
            PRD_FILES="$PRD_FILES$file"$'\n'
            break
        fi
    done
done <<< "$MODIFIED_FILES"

PRD_FILES=$(echo "$PRD_FILES" | sed '/^$/d')

if [ -z "$PRD_FILES" ]; then
    exit 0
fi

# -----------------------------------------------------------------------------
# Check each PRD file for required sections
# -----------------------------------------------------------------------------
ALL_MISSING=""
FILES_CHECKED=0

while IFS= read -r prd_file; do
    [ -z "$prd_file" ] && continue
    if [[ "$prd_file" != /* ]]; then
        prd_file="$CWD/$prd_file"
    fi
    if [ ! -f "$prd_file" ]; then
        continue
    fi

    FILES_CHECKED=$((FILES_CHECKED + 1))
    FILE_BASENAME=$(basename "$prd_file")
    FILE_MISSING=""

    for section in "${REQUIRED_SECTIONS[@]}"; do
        if ! grep -qiE "^#{1,6}\s+.*${section}" "$prd_file" 2>/dev/null; then
            if [ -z "$FILE_MISSING" ]; then
                FILE_MISSING="$section"
            else
                FILE_MISSING="$FILE_MISSING, $section"
            fi
        fi
    done

    if [ -n "$FILE_MISSING" ]; then
        if [ -z "$ALL_MISSING" ]; then
            ALL_MISSING="$FILE_BASENAME is missing: $FILE_MISSING"
        else
            ALL_MISSING="$ALL_MISSING; $FILE_BASENAME is missing: $FILE_MISSING"
        fi
    fi
done <<< "$PRD_FILES"

if [ "$FILES_CHECKED" -eq 0 ]; then
    exit 0
fi

if [ -n "$ALL_MISSING" ]; then
    cat << HOOKEOF
{"decision":"block","reason":"PRD completeness check failed. $ALL_MISSING. Please add the missing sections before finalizing."}
HOOKEOF
    exit 0
fi

exit 0
