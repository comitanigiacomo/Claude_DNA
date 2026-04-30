# Reference — Tolaria Vault Manager

Detailed specifications for advanced use cases.

## Frontmatter Properties

### Built-in Fields

| Field | Type | Purpose | Example |
|-------|------|---------|---------|
| `type` | string | Note category | `Note`, `Project`, `Person` |
| `status` | string | Workflow state | `Active`, `Archived`, `Reviewing` |
| `url` | string | External link | `https://example.com` |
| `created` | date | Auto-managed | (system-generated) |
| `modified` | date | Auto-managed | (system-generated) |

### Relationship Fields

Any field containing wikilinks becomes a relationship:

```yaml
# Scalar relationship
related_to: "[[Main Topic]]"

# Multi-value relationship
references:
  - "[[Source A]]"
  - "[[Source B]]"
```

Tolaria automatically creates backlinks. Both directions are queryable.

### User-Defined Properties

Add any custom properties needed for your schema:

```yaml
priority: high
category: Research
estimated_effort: 3d
owner: "[[Person Name]]"
```

Use these in view filters and sorts.

## View Filter Details

### Filter Tree Structure

Root must be exactly `all:` or `any:`:

```yaml
filters:
  all:                    # All conditions must match
    - field: type
      op: equals
      value: Note
    - field: status
      op: equals
      value: Active
```

### Operator Reference

**Equality**:
- `equals` — exact match
- `not_equals` — exclude match

**String matching**:
- `contains` — substring search
- `not_contains` — exclude substring
- `regex: true` — use regex pattern (with `equals`, `not_equals`, `contains`, `not_contains`)

**Set operations**:
- `any_of` — match any value in list
- `none_of` — match none of values in list

**Emptiness**:
- `is_empty` — no value set
- `is_not_empty` — any value present

**Date comparison**:
- `before` — created/modified before date
- `after` — created/modified after date

### Filtering Relationships

Relationship filters support wikilinks:

```yaml
filters:
  any:
    - field: related_to
      op: contains
      value: "[[Tolaria]]"
```

### Regex Examples

```yaml
# Match notes with numbers in title
- field: title
  op: contains
  regex: true
  value: "\\d+"

# Match active or in-progress status
- field: status
  op: any_of
  value:
    - Active
    - In Progress
```

## Sort Specifications

### Built-in Sorts

```yaml
sort: "modified:desc"     # Most recent first
sort: "created:asc"       # Oldest first
sort: "title:asc"         # Alphabetical
sort: "status:asc"        # By status field
```

### Property Sorts

Sort by any custom property:

```yaml
sort: "property:priority:desc"        # High priority first
sort: "property:estimated_effort:asc" # Shortest first
```

## Icons and Colors

### Icon Set

Common sidebar icons (Tolaria supports standard Unicode/emoji and material-design icon names):

```yaml
_icon: book
_icon: rocket
_icon: star
_icon: folder
_icon: person
_icon: checkbox
_icon: pencil
_icon: archive
```

### Color Hex Values

Use standard hex colors:

```yaml
_color: "#3b82f6"   # Blue
_color: "#ef4444"   # Red
_color: "#10b981"   # Green
_color: "#f59e0b"   # Amber
_color: "#8b5cf6"   # Purple
```

## Filename Conventions

### Kebab-Case Rules

- Lowercase only
- Separate words with hyphens
- No spaces, underscores, or special chars (except hyphens)
- No file extensions in wikilinks

**Good**:
- `my-research-note.md`
- `2024-planning.md`
- `john-doe.md`

**Bad**:
- `MyResearchNote.md`
- `my_research_note.md`
- `my research note.md`

### Directory Structure

```
vault-root/
├── AGENTS.md                    # Vault conventions (do not edit)
├── note-type.md                 # Type definition at root
├── project.md                   # Type definition
├── another-note.md              # Note file
├── views/
│   ├── active-items.yml         # Saved view
│   └── by-priority.yml
└── attachments/                 # Assets only, not notes
    ├── image.png
    └── reference.pdf
```

## Vault Maintenance

### Checking Type Consistency

Before bulk operations, verify all referenced types exist at vault root:

```bash
grep -h "^type:" **/*.md | sort | uniq
```

All values must have corresponding `.md` files at root.

### Updating Relationships Safely

When renaming a note:
1. Update the note's filename
2. Update all wikilink references in other notes
3. Check backlink views to ensure consistency

### Archiving Notes

Instead of deleting, set status:

```yaml
status: Archived
```

This preserves graph integrity and backlinks.

## Common Schemas

### Project Type

```yaml
---
type: Type
_icon: rocket
_color: "#3b82f6"
_list_properties_display:
  - status
  - owner
  - due_date
---

# Project

A tracked initiative with timeline and ownership.
```

### Person Type

```yaml
---
type: Type
_icon: person
_color: "#8b5cf6"
_list_properties_display:
  - email
  - related_to
---

# Person

Individual contact with relationships.
```

### Research Note Type

```yaml
---
type: Type
_icon: book
_color: "#10b981"
_list_properties_display:
  - status
  - tags
  - references
---

# Research Note

Investigation documentation with source citations.
```

## Migration Tips

If importing notes from other systems:

1. Create target Types first at vault root
2. Convert titles to H1 in body (remove `title:` frontmatter)
3. Convert all relationships to wikilinks
4. Use kebab-case for filenames
5. Validate all type references exist
6. Create views to surface newly imported data
