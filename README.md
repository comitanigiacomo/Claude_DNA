# Claude DNA

> [!CAUTION]
> This repository is under constant development. I create and refine skills on the fly as soon as I identify a new requirement or a specific area where the model needs better instructions.

This repository serves as a central warehouse for the modular AI skills I use to interact with LLMs.

### Current Skills Overview

#### Base (Global Context)
* **create-skills**: copied from [mattpocock/skills](https://github.com/mattpocock/skills) to ensure efficient and correctly formatted skill generation.
* **identity**: Configures the AI as a high-level software engineer—direct, technical, and precise.
* **work-environment**: Ensures all suggestions respect my Fedora setup while keeping the host system clean and following terminal-first practices.

#### Tools (On-Demand Modules)
* **git-specialist**: Focused on professional Git workflows, conventional commit messages, and maintaining a clean history.
* **debian**: Specialized for home server (Debian) management, emphasizing Docker isolation and system hygiene.
* **report-reviewer**: Tailored for academic project reports, focusing on logical structure, formal tone, and rigorous documentation.
* **clean-code**: A general-purpose reviewer for enforcing architectural standards and high-quality code.

### Setup & Workflow
My current setup is built around [**OpenCode**](https://opencode.ai/):

1. **Injection**: Once in the project directory, the [inject-skills](./scripts/inject-skills.sh) script syncs the relevant markdown files directly into the workspace.
2. **Selection**: Inside OpenCode, I use the `/skills` command to selectively activate the modules required for the current session.