---
name: environment
description: Enforce clean Fedora system hygiene and development environment isolation. Govern runtime installations via Mise, mandate virtual environments for lightweight projects, use Docker/Compose strictly for stateful services, and manage backups to the remote Debian server. Use when setting up projects, managing dependencies, or handling data persistence.
---

# Environment: Fedora System Hygiene & Isolation

## Quick start

Enforce these non-negotiable rules:

1. **Runtimes & VEnvs via Mise** - Runtimes installed via Mise; local virtual environments auto-activated by `.mise.toml`.
2. **Never use dnf/pip/npm globally** - Project libraries must remain strictly local.
3. **Stateful Services in Docker** - Databases, caches, and brokers run in Compose, never native.
4. **Debian Server is for BACKUP ONLY** - No remote execution. Use it exclusively for data synchronization and archiving.

## Core Principles

### 1. Mise is the Source of Truth (Runtimes & VEnvs)
- **Runtimes**: Node.js, Python, Go, Rust, Ruby installed via `mise install`.
- **Isolation**: Lightweight projects use local virtual environments (e.g., Python `.venv`).
- **Auto-activation**: The `.mise.toml` file must be configured to automatically activate and deactivate the virtual environment upon entering/exiting the directory.
- No system-wide `dnf install nodejs` or `apt install python3-dev`.

### 2. Absolute Ban on Global Package Managers
- ❌ `dnf install python-requests`
- ❌ `pip install --user requests`
- ❌ `npm install -g express`

- ✅ Use `package.json`, `pyproject.toml`, `requirements.txt` → managed locally.
- ✅ All installations must happen *inside* the active virtual environment or local `node_modules`.

### 3. Service Isolation (Docker for Stateful Services only)
Do not use Docker for simple code execution if a virtual environment suffices. However, services **never** run on localhost natively:
- PostgreSQL, MongoDB, Redis → `docker-compose.yml`
- RabbitMQ, Kafka → `docker-compose.yml`

**Benefits**:
- Fedora remains clean of system-level daemon pollution.
- Easy teardown/reset.

**Template**:
```yaml
version: '3.8'
services:
  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_PASSWORD: dev
    ports:
      - "5432:5432"
```

### 4. Debian Server Backup Protocol
The remote Debian server is **NOT** for execution. It is the designated backup vault.
- Do not suggest running workloads, containers, or CI jobs on Debian.
- When generating automation scripts, ensure data sync commands (e.g., `rsync`, `scp`) target the Debian server for backup purposes.

## Enforcement Rules

### Rule 1: Project Setup Validation
When proposing a new project setup:
```text
❌ "Let's create a Dockerfile for this simple Python script"
✅ "Let's create a .mise.toml to set the Python version and automatically activate a .venv folder"
```

### Rule 2: Dependency Validation
When proposing library installation:
```text
❌ "pip install django" (assumes global)
✅ "Ensure you are in the Mise-managed .venv, then run pip install django and update requirements.txt"
```

### Rule 3: Service Validation
When proposing running a database:
```text
❌ "dnf install postgresql && systemctl start postgresql"
✅ "Define in docker-compose.yml, use 'docker-compose up -d'"
```

### Rule 4: Backup Validation
When discussing data persistence or project completion:
```text
❌ "Let's deploy this to your Debian server"
✅ "Let's write a backup script to rsync this project directory to your Debian server vault"
```

## Example Scenarios

### Scenario 1: Python API Project
```text
Requested: "Setup a FastAPI project"

❌ Use Docker for the Python code
✅ Create .mise.toml:
   [tools]
   python = "3.11"
   [env]
   VIRTUAL_ENV = ".venv"
✅ Create .venv: python -m venv .venv
✅ Install dependencies inside .venv
```

### Scenario 2: Adding a Database to a Project
```text
Requested: "I need Postgres for this FastAPI project"

❌ dnf install postgresql
✅ Add docker-compose.yml with postgres:15-alpine
✅ Run: docker-compose up -d
✅ Connect Python (in .venv) to localhost:5432
```

### Scenario 3: End of Session / Archiving
```text
Requested: "I'm done with this university project"

❌ Leave it on Fedora indefinitely
✅ Propose an rsync command: 
   rsync -avz --exclude '.venv' --exclude 'node_modules' ./project debian-user@debian-server:/backups/university/
```

## Quick Reference: Forbidden vs. Allowed

| Task | ❌ Forbidden | ✅ Allowed |
|------|-----------|---------|
| Install Python 3.11 | `dnf install python3` | `mise install` (via .mise.toml) |
| Isolate simple project | Docker container | `.venv` auto-activated by Mise |
| Run PostgreSQL | `dnf install postgresql` | `docker-compose.yml + compose up` |
| Debian Server usage | Run tests/workloads | Rsync/backup storage only |

## When This Skill Activates
Use this persona when setting up new projects, adding dependencies, provisioning local databases, or writing backup scripts. Enforce these rules consistently.