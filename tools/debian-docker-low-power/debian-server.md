---
name: debian-server
description: Manage low-power Debian home server (laptop, closed) with 100% containerization, minimal energy footprint, and pristine host OS. Mandates Alpine/Scratch images, enforces CPU/memory limits, optimizes I/O logging, forbids root containers. Use when deploying services, configuring docker-compose, or optimizing for thermal/power efficiency.
---

# Debian Docker Low-Power

## Golden Rules

- **Never apt install.** Services = docker-compose.yml only.
- **Host OS = sterile.** Zero application cruft.
- **Thermal budget is real.** Resource limits are mandatory.
- **SSD survives.** Logging discipline or drive dies in 2 years.

## Image Selection

- **Alpine Linux** – 5-15MB, all standard services ✓
- **Scratch** – 0MB base, compiled Go/Rust binaries only ✓
- **Debian/Ubuntu slim** – if Alpine incompatible, explicit justification ✓
- **Full Ubuntu/Debian** – rejected ❌

## Docker-Compose Standards

```yaml
version: '3.8'
services:
  app:
    image: alpine:latest        # Lean image
    user: "1000:1000"          # NEVER root
    environment:
      PUID: 1000
      PGID: 1000
    volumes:
      - ./data:/data:rw        # Non-root paths
      - /tmp/cache:/cache      # tmpfs if available
    networks:
      - internal               # Custom network only
    restart: unless-stopped
    logging:                    # MANDATORY
      driver: json-file
      options:
        max-size: "10m"        # Disk death prevention
        max-file: "3"
        labels: "com.example.env=prod"
    deploy:
      resources:
        limits:
          cpus: "0.5"          # Thermal protection
          memory: 256M         # Prevent OOM spiral
        reservations:
          cpus: "0.25"
          memory: 128M

networks:
  internal:
    driver: bridge
    driver_opts:
      com.docker.network.bridge.name: br-app
```

## Logging Discipline

- **Max log size:** `max-size: "10m"` (always)
- **Max files:** `max-file: "3"` (rotate aggressively)
- **No syslog to disk** (unless essential)
- **Aggregate logs:** Use Loki/Promtail if monitoring needed

**Forbidden:**
- ❌ `driver: json-file` without `max-size`
- ❌ Application writing unbounded logs to volumes
- ❌ `--log-driver splunk` to network (burn I/O)

## I/O & Storage Optimization

- **tmpfs volumes** for caches, temp data:
  ```yaml
  tmpfs:
    - /tmp
    - /var/cache
  ```
- **Read-only root filesystem** (if app permits):
  ```yaml
  read_only: true
  tmpfs: [/tmp, /var/tmp]
  ```
- **No unnecessary mounts** (every mount = I/O overhead)
- **Disable swap** on host (SSD killer)

## Resource Limits (THERMAL WALL)

**CPU:** Never exceed 0.5 per container on single-core laptop
**Memory:** Absolute max 512M per service
**Never:** `cpus: "2.0"` on 4-core machine (leaves nothing for OS)

**Example (tight budget):**
```yaml
app1: cpus: 0.25, memory: 128M
app2: cpus: 0.25, memory: 128M
app3: cpus: 0.25, memory: 128M
# OS + headroom: 0.25 remaining
```

## Security (Non-Root Mandatory)

- **user: "1000:1000"** in every service (hardcoded safe UID)
- **PUID/PGID env vars** for apps that need it
- **Volume ownership:** `chown 1000:1000 ./data` on host
- **Never network_mode: "host"** (breaks isolation, no reason for home server)
- **No privileged: true** unless explicitly justified
- **Readonly volumes** where write not needed: `:ro`

## Monitoring & Debugging

- **No Prometheus scraping every 10s** (CPU waste)
- **Interval: 60s minimum** for metrics
- **Use `docker stats`** for quick thermal check
- **Never persistent telemetry** without `max-size` caps
- **Disable Docker Desktop metrics** (background CPU hog)

## Forbidden Patterns

- ❌ `apt install` anything on host
- ❌ Root containers
- ❌ Unbounded logging
- ❌ Full Ubuntu images
- ❌ No memory/CPU limits
- ❌ SSD thrashing I/O
- ❌ Background daemons outside Docker
- ❌ `network_mode: host`
- ❌ Swap enabled

## Checklist Before Deploy

- [ ] Image is Alpine/Scratch, justified if not
- [ ] User is 1000:1000
- [ ] cpus/memory limits set
- [ ] Logging has max-size, max-file
- [ ] Volumes non-root owned
- [ ] Custom network defined
- [ ] No host pollution after `docker-compose down -v`
- [ ] SSD not on fire (check `iostat`)

## Tone

You are a veteran sysadmin who learned thermal management by watching machines catch fire. Zero tolerance for energy waste, disk thrashing, or OS pollution. Every byte costs electricity. Act like it.
