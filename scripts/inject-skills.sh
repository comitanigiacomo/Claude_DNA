#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
SKILLS_REPO="$(dirname "$SCRIPT_DIR")"
TARGET_ROOT=".opencode/skills"
UPDATED=0

echo "Scanning for skills in: $SKILLS_REPO"

# 1. Validate repository structure
if [ ! -d "$SKILLS_REPO/base" ]; then
    echo "Error: Repository structure not recognized (missing 'base' directory)."
    exit 1
fi

# 2. Iterate strictly over allowed semantic categories
for category in base tools second-brain; do
    [ -d "$SKILLS_REPO/$category" ] || continue

    for skill_dir in "$SKILLS_REPO/$category"/*; do
        [ -d "$skill_dir" ] || continue

        skill_name=$(basename "$skill_dir")
        target_dir="$TARGET_ROOT/$skill_name"
        target_file="$target_dir/SKILL.md"
        
        mkdir -p "$target_dir"

        # Case A: Advanced multi-file structure (SKILL.md, EXAMPLES.md, etc.)
        # Copy ONLY the SKILL.md file to prevent prompt pollution
        if [ -f "$skill_dir/SKILL.md" ]; then
            if [ ! -f "$target_file" ] || ! cmp -s "$skill_dir/SKILL.md" "$target_file"; then
                cp "$skill_dir/SKILL.md" "$target_file"
                echo "Updated (from SKILL.md): $skill_name"
                UPDATED=1
            fi

        # Case B: Legacy single-file structure
        else
            # Grab the FIRST .md file and copy it as SKILL.md, then stop
            for file in "$skill_dir"/*.md; do
                [ -e "$file" ] || continue
                if [ ! -f "$target_file" ] || ! cmp -s "$file" "$target_file"; then
                    cp "$file" "$target_file"
                    echo "Injected (from legacy): $skill_name"
                    UPDATED=1
                fi
                break # CRITICAL: exit loop to ignore extra .md files
            done
        fi
    done
done

# 3. Idempotent gitignore management
if [ -d ".git" ] || [ -f ".gitignore" ]; then
    if ! grep -q "^\.opencode/" .gitignore 2>/dev/null; then
        echo ".opencode/" >> .gitignore
        echo ".opencode/ added to local .gitignore."
        UPDATED=1
    fi
fi

# 4. Final state evaluation
if [ $UPDATED -eq 0 ]; then
    echo "All skills are already present (1 file per skill) and up to date."
fi