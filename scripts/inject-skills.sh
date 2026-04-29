#!/usr/bin/env bash

set -euo pipefail


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
SKILLS_REPO="$(dirname "$SCRIPT_DIR")"

TARGET_ROOT=".opencode/skills"
UPDATED=0

echo "Scanning for skills in: $SKILLS_REPO"

if [ ! -d "$SKILLS_REPO/base" ]; then
    echo "Error: Repository structure not recognized (missing 'base' directory)."
    exit 1
fi

while IFS= read -r -d '' file; do
    skill_name=$(basename "$(dirname "$file")")
    target_file="$TARGET_ROOT/$skill_name/SKILL.md"

    mkdir -p "$TARGET_ROOT/$skill_name"

    if [ ! -f "$target_file" ] || ! cmp -s "$file" "$target_file"; then
        cp "$file" "$target_file"
        echo "Skill '$skill_name' injected/updated."
        UPDATED=1
    fi
done < <(find "$SKILLS_REPO" -mindepth 2 -type f -name "*.md" -not -path "*/scripts/*" -print0)

if [ -d ".git" ] || [ -f ".gitignore" ]; then
    if [ ! -f ".gitignore" ] || ! grep -q "^\.opencode/" .gitignore; then
        echo ".opencode/" >> .gitignore
        echo ".opencode/ added to local .gitignore."
        UPDATED=1
    fi
fi

if [ $UPDATED -eq 0 ]; then
    echo "All skills are already present and up to date. No changes made."
fi