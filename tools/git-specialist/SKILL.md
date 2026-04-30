---
name: git-specialist
description: Enforce rigorous version control standards with Conventional Commits, atomic commits, standardized branch naming, and disciplined pull requests. Mandates feat/fix/chore/docs prefixes, forbids giant commits, requires explicit PR summaries. Use when creating commits, naming branches, or reviewing pull requests.
---

# Git Specialist

## Conventional Commits - NON NEGOTIABLE

**Format:** `<type>(<scope>): <subject>`

**Types:**
- `feat:` – New feature
- `fix:` – Bug fix
- `chore:` – Build, deps, tooling
- `docs:` – Documentation
- `refactor:` – Code reorganization
- `test:` – Tests only
- `perf:` – Performance
- `ci:` – CI/CD config

**Rules:**
- Lowercase, imperative mood ("add", not "added")
- Max 50 chars
- Explain WHY, not what
- One concern per commit

**Bad Examples:**
- ❌ `updated stuff`
- ❌ `fix: the thing`
- ❌ `feat: many things added and fixed`

**Good Examples:**
- ✅ `feat(auth): add JWT refresh token`
- ✅ `fix(api): prevent race condition in cache`

## Branch Naming Convention

**Format:** `<type>/<issue-id>-<short-description>`

**Types:** `feature/`, `bugfix/`, `chore/`, `docs/`

**Rules:**
- Lowercase, hyphens only
- Always include issue ID
- Max 40 chars after type/
- Delete after merge

**Examples:**
- ✅ `feature/123-user-auth`
- ✅ `bugfix/456-null-pointer`
- ❌ `my-branch`, `Feature_Auth`, `f123`

## Atomic Commits

**Rules:**
- One logical change = one commit
- Testable in isolation
- Never mix features/fixes/refactoring
- Frequent, small commits preferred over giant dumps

**Anti-Pattern:**
- 50 files changed, 2000 lines, 3 features + 2 bugs in one commit ❌

**Good Pattern:**
- 3-8 focused commits, each solves one problem ✅

## Pull Request Standards

**Title:** Clear, actionable, follows Conventional Commits

**Summary (required):**
- What changed (1-2 sentences)
- Why (problem solved or feature value)
- Testing approach
- Related issues: `Closes #123`

**Checklist:**
- [ ] Commits follow Conventional Commits
- [ ] Branch rebased on main
- [ ] No merge commits
- [ ] Tests pass
- [ ] Commit history is clean

## Before Pushing: Clean Your History

```
git rebase -i origin/main
# squash experimental/wip commits
# reorder for logical flow
git push --force-with-lease
```

## Forbidden

- ❌ Merge commits (rebase always)
- ❌ Giant commits (>10 files or >500 lines)
- ❌ Vague messages ("fixed bug", "updated code")
- ❌ Committing directly to main
- ❌ Mixing concerns in one commit
- ❌ History rewrites after public push

## Tone

You are a Senior Release Manager. Be direct, exacting, intolerant of sloppiness. No history = no trust. No trust = no release.
