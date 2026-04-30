---
name: tolaria-vault-manager
description: Manage Tolaria personal knowledge graph vault with notes, types, relationships, and saved views. Use when creating/editing notes, designing type schemas, building filtered views, or managing knowledge relationships in Tolaria.
---

# Tolaria Vault Manager

Manage your Tolaria vault following strict conventions for maintainability and graph coherence.

## Core Principles

- **One note per file** — no aggregates
- **Kebab-case filenames** — `my-note-title.md`
- **H1 titles in body** — first markdown heading is the display title (not frontmatter `title:`)
- **Type-driven schema** — all notes have a `type:` field matching a Type definition at vault root
- **Relationship integrity** — wikilinks in frontmatter create the knowledge graph
- **No silent overwrites** — preserve existing structure unless user explicitly requests changes

## Quick Start: Create a Note

```yaml
---
type: Note
related_to: "[[Tolaria]]"
status: Active
---

# My Note Title

Body content in Markdown.
```

**File**: `my-note-title.md`

## Workflows

### Creating a Note

1. Determine the note's **type** (must exist as a Type at vault root)
2. Write filename in **kebab-case**: `my-note-title.md`
3. Add **frontmatter**:
   - `type:` (required) — matches a Type definition
   - `status:` (optional) — e.g., Active, Archived, Reviewing
   - Relationship fields as **quoted wikilinks** or **YAML lists**
   - Custom properties (url, tags, etc.)
4. Write **H1 title** as first markdown line in body (do NOT use frontmatter `title:`)
5. Add markdown content below H1

**Checklist**:
- [ ] Filename is kebab-case
- [ ] Type exists at vault root
- [ ] First line of body is `# Title`
- [ ] Relationships use `[[WikiLink]]` syntax
- [ ] No conflicting properties with existing notes

### Creating a Type

1. Filename: `type-name.md` at **vault root only**
2. Set `type: Type` in frontmatter
3. Add metadata:
   - `_icon:` — sidebar icon
   - `_color:` — accent color (hex)
   - `_order:` — sidebar position (integer)
   - `_list_properties_display:` — YAML list of frontmatter keys to show in lists
   - `_sort:` — default sorting: `property:PropertyName:asc` or `modified:desc`
4. Write H1 and optional description

**Example**:
```yaml
---
type: Type
_icon: book
_color: "#3b82f6"
_order: 1
_list_properties_display:
  - related_to
  - status
---

# Project

A project with clear goals and timeline.
```

**Checklist**:
- [ ] File at vault root (not subdirectory)
- [ ] Uses `type: Type` in frontmatter
- [ ] Filename ends in `.md`
- [ ] Icon/color chosen from valid set
- [ ] Related notes can reference this type

### Creating a Saved View

1. Filename: `views/view-name.yml` (kebab-case)
2. YAML structure:
   - `name:` (required) — display name
   - `icon:` and `color:` (optional)
   - `sort:` (optional) — e.g., `property:status:asc`
   - `filters:` (required) — filter tree with single root (`all:` or `any:`)

**Operators**: `equals`, `not_equals`, `contains`, `not_contains`, `any_of`, `none_of`, `is_empty`, `is_not_empty`, `before`, `after`

**Example**:
```yaml
name: Active Research
icon: null
color: null
sort: "property:status:asc"
filters:
  any:
    - field: type
      op: equals
      value: Note
    - field: status
      op: equals
      value: Active
```

**Checklist**:
- [ ] File in `views/` directory
- [ ] Filename is kebab-case with `.yml` extension
- [ ] `name` is set
- [ ] `filters` has exactly one root (`all:` or `any:`)
- [ ] All filter conditions use valid operators

### Managing Relationships

**Scalar relationship** (single value):
```yaml
related_to: "[[Target Note Title]]"
belongs_to: "[[Project Name]]"
```

**Multi-value relationship** (YAML list):
```yaml
references:
  - "[[Note One]]"
  - "[[Note Two]]"
```

**Preserve existing relationship labels** when editing notes that already use `Belongs to:` or other custom formats.

**Checklist**:
- [ ] Wikilinks are quoted in YAML
- [ ] Target note or type exists
- [ ] Multi-value uses YAML list syntax
- [ ] No circular hard dependencies

## What to Avoid

- ❌ Do not move Type files out of vault root
- ❌ Do not create notes in `attachments/` (assets only)
- ❌ Do not use unquoted wikilinks in frontmatter
- ❌ Do not add `title:` to frontmatter (use H1 in body)
- ❌ Do not create `.view.json` files (use `.yml` only)
- ❌ Do not edit Tolaria-managed properties (`_*` prefix) unless explicitly asked
- ❌ Do not treat `AGENTS.md` as a note type

## Advanced Features

See [REFERENCE.md](REFERENCE.md) for:
- Regex filtering in views
- Icon and color palettes
- Property types and validation
- Vault maintenance workflows
