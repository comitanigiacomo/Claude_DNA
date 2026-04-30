# Claude DNA

> [!CAUTION]
> This repository is under constant development. I create and refine skills as soon as I identify a new requirement or a specific area where the model needs better instructions.

This repository serves as a central warehouse for the modular AI skills I use to interact with LLMs. 

### Architecture
The repository uses a semantic folder structure. Skills can either be a single file or a rich module containing multiple files (like `EXAMPLES.md` or `REFERENCE.md`). The core prompt for every skill is now standardized as `SKILL.md`.

### Current Skills Overview

#### Base (Global Context)
* **create-skills**: Copied from [mattpocock/skills](https://github.com/mattpocock/skills) to ensure efficient and correctly formatted skill generation.
* **identity**: Configures the AI as a high-level software engineer—direct, technical, and precise.
* **work-environment**: Ensures all suggestions respect my Fedora setup while keeping the host system clean and following terminal-first practices.

#### Tools (On-Demand Modules)
* **clean-code-architect**: A general-purpose reviewer for enforcing architectural standards and high-quality code.
* **debian-server**: Specialized for home server (Debian) management, emphasizing Docker isolation and system hygiene.
* **git-specialist**: Focused on professional Git workflows, conventional commit messages, and maintaining a clean history.
* **report-reviewer**: Tailored for academic project reports, focusing on logical structure, formal tone, and rigorous documentation.

#### Second Brain (Knowledge Management)
* **tolaria-vault-manager**: Specialized instructions for managing a local, Git-first Markdown knowledge base using Tolaria. It ensures the AI respects YAML frontmatter rules, bidirectional wikilinks, and file naming conventions.

### Setup & Workflow
My current setup is built around [**OpenCode**](https://opencode.ai/):

1. **Injection**: Once in the project directory, run the [`./scripts/inject-skills.sh`](./scripts/inject-skills.sh) script. It is an idempotent bash script that parses the repository and safely copies only the `SKILL.md` files into the local `.opencode/skills/` directory, preventing context pollution.
2. **Selection**: Inside OpenCode, use the `/skills` command to selectively activate the required modules (identified by their folder name) for the current session.