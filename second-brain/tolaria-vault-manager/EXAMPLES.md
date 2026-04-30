# Examples — Tolaria Vault Manager

Practical workflows for common scenarios.

## Example 1: Building a Research Vault

### Setup Types

**Create `research-note.md` at vault root**:
```yaml
---
type: Type
_icon: book
_color: "#10b981"
_order: 1
_list_properties_display:
  - status
  - source
  - related_to
---

# Research Note

Investigation documentation with source citations.
```

**Create `source.md`**:
```yaml
---
type: Type
_icon: link
_color: "#6366f1"
_order: 2
_list_properties_display:
  - url
  - accessed_date
---

# Source

External reference material.
```

### Create Notes

**File: `neural-networks-basics.md`**:
```yaml
---
type: Research Note
status: Active
source: "[[Deep Learning Book]]"
related_to:
  - "[[Machine Learning]]"
  - "[[Mathematics]]"
---

# Neural Networks Basics

Discussion of fundamental concepts in neural networks, including:
- Forward propagation
- Backpropagation
- Gradient descent

See also [[Mathematics]] for linear algebra foundations.
```

**File: `deep-learning-book.md`**:
```yaml
---
type: Source
url: https://www.deeplearningbook.org/
accessed_date: 2024-04-28
---

# Deep Learning Book

Comprehensive textbook on deep learning by Goodfellow, Bengio, Courville.
```

### Create Views

**File: `views/active-research.yml`**:
```yaml
name: Active Research
icon: null
color: null
sort: "modified:desc"
filters:
  all:
    - field: type
      op: equals
      value: Research Note
    - field: status
      op: equals
      value: Active
```

**File: `views/by-source.yml`**:
```yaml
name: Notes by Source
icon: null
color: null
sort: "property:source:asc"
filters:
  all:
    - field: type
      op: equals
      value: Research Note
```

---

## Example 2: Project Tracking Vault

### Define Project Type

**File: `project.md`**:
```yaml
---
type: Type
_icon: rocket
_color: "#ef4444"
_order: 0
_list_properties_display:
  - status
  - owner
  - due_date
  - priority
_sort: "property:priority:desc"
---

# Project

Initiative with clear scope, owner, and timeline.
```

### Create Project Notes

**File: `redesign-landing-page.md`**:
```yaml
---
type: Project
status: In Progress
owner: "[[Alice Chen]]"
due_date: 2024-05-31
priority: high
related_to: "[[Marketing]]"
---

# Redesign Landing Page

Modernize landing page for 2024 brand refresh.

## Goals
- Improve conversion rate by 15%
- Mobile-first responsive design
- A/B testing framework

## Timeline
- Week 1-2: Design mockups
- Week 3-4: Development
- Week 5: QA and launch
```

### Status-Based Views

**File: `views/active-projects.yml`**:
```yaml
name: Active Projects
icon: null
color: null
filters:
  any:
    - field: status
      op: equals
      value: In Progress
    - field: status
      op: equals
      value: Blocked
```

**File: `views/high-priority.yml`**:
```yaml
name: High Priority
icon: null
color: null
sort: "property:due_date:asc"
filters:
  all:
    - field: type
      op: equals
      value: Project
    - field: priority
      op: equals
      value: high
```

---

## Example 3: Meeting Notes with Follow-ups

### Meeting Type

**File: `meeting.md`**:
```yaml
---
type: Type
_icon: checkbox
_color: "#3b82f6"
_list_properties_display:
  - attendees
  - date
  - related_to
---

# Meeting

Recorded discussion with decisions and action items.
```

### Create Meeting Note

**File: `q2-planning-session-2024.md`**:
```yaml
---
type: Meeting
date: 2024-04-26
attendees:
  - "[[Alice Chen]]"
  - "[[Bob Zhang]]"
related_to:
  - "[[Redesign Landing Page]]"
  - "[[Marketing Strategy]]"
---

# Q2 Planning Session 2024

## Attendees
- Alice Chen (Product)
- Bob Zhang (Engineering)

## Decisions
- Prioritize landing page redesign (high impact)
- Allocate 2 engineers for Q2
- Start user testing in May

## Action Items
- [ ] Alice: Create detailed project spec
- [ ] Bob: Estimate engineering effort
- [ ] Marketing: Prepare assets

## Next Steps
Schedule follow-up for May 1st.
```

### Query View: All Meetings by Person

**File: `views/meetings-by-owner.yml`**:
```yaml
name: Meetings by Owner
icon: null
color: null
sort: "property:date:desc"
filters:
  all:
    - field: type
      op: equals
      value: Meeting
    - field: attendees
      op: contains
      value: "[[Alice Chen]]"
```

---

## Example 4: Complex Filtering

### View: Active Items Across Multiple Projects

```yaml
name: Active Across Projects
icon: null
color: null
sort: "property:due_date:asc"
filters:
  all:
    - field: status
      op: any_of
      value:
        - Active
        - In Progress
        - Blocked
    - field: type
      op: any_of
      value:
        - Project
        - Task
    - field: modified
      op: after
      value: "2024-04-01"
```

### View: All Research (Regex Example)

```yaml
name: Research Related
icon: null
color: null
filters:
  any:
    - field: type
      op: equals
      value: Research Note
    - field: title
      op: contains
      regex: true
      value: "^(Research|Study|Analysis)"
```

---

## Example 5: Relationship-Driven Architecture

### Create Person and Team Types

**File: `person.md`**:
```yaml
---
type: Type
_icon: person
_color: "#a855f7"
_list_properties_display:
  - email
  - team
---

# Person

Team member with contact info.
```

**File: `team.md`**:
```yaml
---
type: Type
_icon: users
_color: "#6366f1"
_list_properties_display:
  - members
---

# Team

Group of people working together.
```

### Create Interconnected Notes

**File: `engineering.md`**:
```yaml
---
type: Team
members:
  - "[[Alice Chen]]"
  - "[[Bob Zhang]]"
---

# Engineering
```

**File: `alice-chen.md`**:
```yaml
---
type: Person
email: alice@example.com
team: "[[Engineering]]"
related_to:
  - "[[Redesign Landing Page]]"
  - "[[Performance Optimization]]"
---

# Alice Chen
```

### View: Team Workload

```yaml
name: Alice's Projects
icon: null
color: null
filters:
  all:
    - field: type
      op: equals
      value: Project
    - field: owner
      op: contains
      value: "[[Alice Chen]]"
```

---

## Workflow: Renaming a Note

If `old-title.md` needs to become `new-title.md`:

1. **Rename the file**
2. **Update all wikilinks** in the vault:
   ```yaml
   # Change all instances of:
   related_to: "[[old title]]"
   # To:
   related_to: "[[new title]]"
   ```
3. **Verify backlinks** in Tolaria UI render correctly
4. **Check views** don't depend on old filename

---

## Workflow: Adding a New Type

1. Create `new-type.md` at vault root
2. Set `type: Type` and add metadata
3. Create at least one test note with new type
4. Create a view to list notes of new type
5. Update any documentation or type lists

Example adding `goal.md`:

```yaml
---
type: Type
_icon: target
_color: "#f59e0b"
_list_properties_display:
  - status
  - deadline
---

# Goal

Measurable objective with timeline.
```

Then create `views/all-goals.yml` and a test goal note.
