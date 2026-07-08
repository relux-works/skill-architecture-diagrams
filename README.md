# Architecture Diagrams Skill

Architecture diagrams as code for AI agents. Structurizr DSL (C4 model), PlantUML (all UML types), and Graphviz, with patterns, templates, and references.

## Features

- **Structurizr DSL (C4):** System Context, Container, Component diagrams with modular workspace pattern
- **PlantUML:** Sequence, Component, Activity, Class, State, Use Case, Deployment, Object diagrams
- **Graphviz:** Quick dependency graphs via DOT notation
- **Templates:** Starter workspace and diagram templates ready to copy
- **References:** Syntax reference for each diagram type

## Setup

```bash
./scripts/setup.sh
```

Creates symlinks into `~/.agents/skills/`, `~/.claude/skills/`, and `~/.codex/skills/`.

### Teardown

```bash
./scripts/deinit.sh
```

Removes all symlinks. Does not delete any files.

### Manual Setup

```bash
# Symlink into agents skills
ln -s ~/src/skill-architecture-diagrams ~/.agents/skills/architecture-diagrams

# Symlink for Claude Code
ln -s ~/.agents/skills/architecture-diagrams ~/.claude/skills/architecture-diagrams

# Symlink for Codex CLI
ln -s ~/.agents/skills/architecture-diagrams ~/.codex/skills/architecture-diagrams
```

## Requirements

- **Structurizr CLI**: `brew install structurizr-cli` (alias `structurizr` recommended)
- **PlantUML**: download JAR: `curl -L -o .temp/plantuml.jar https://github.com/plantuml/plantuml/releases/latest/download/plantuml.jar`
- **Graphviz**: `brew install graphviz`

## AI Agent Skill Setup

This repo is an AI agent skill compatible with coding agents (Claude Code, Codex CLI, and similar tools).

### With `~/.agents/` infrastructure

If you use [alexis-agents-infra](https://github.com/anthropics/alexis-agents-infra) for managing global instructions and skills:

```bash
git clone <repo-url> ~/src/skill-architecture-diagrams
cd ~/src/skill-architecture-diagrams
./scripts/setup.sh
```

### Direct setup (without agents-infra)

```bash
git clone <repo-url> ~/src/skill-architecture-diagrams
mkdir -p ~/.claude/skills ~/.codex/skills
ln -s ~/src/skill-architecture-diagrams ~/.claude/skills/architecture-diagrams
ln -s ~/src/skill-architecture-diagrams ~/.codex/skills/architecture-diagrams
```

## Structure

```
skill-architecture-diagrams/
├── SKILL.md                         # Skill specification (patterns, commands, best practices)
├── references/                      # Syntax references for each diagram type
│   ├── structurizr-dsl.md
│   ├── plantuml-sequence.md
│   ├── plantuml-component.md
│   ├── plantuml-activity.md
│   ├── plantuml-class.md
│   ├── plantuml-state.md
│   ├── plantuml-usecase.md
│   ├── plantuml-deployment.md
│   └── plantuml-object.md
├── templates/                       # Starter templates
│   ├── c4-workspace/                # Structurizr DSL workspace scaffold
│   │   ├── workspace.dsl
│   │   ├── model/
│   │   ├── views/
│   │   └── styles/
│   ├── plantuml/                    # PlantUML diagram templates
│   │   ├── sequence-template.puml
│   │   └── component-template.puml
│   └── diagrams-readme.md           # README template for diagrams/ folder
└── scripts/
    ├── setup.sh                     # Install symlinks
    └── deinit.sh                    # Remove symlinks
```

## Tools Used

| Tool | Purpose | Install |
|------|---------|---------|
| Structurizr CLI | C4 model diagrams | `brew install structurizr-cli` |
| PlantUML | UML diagrams | `curl -L -o plantuml.jar https://github.com/plantuml/plantuml/releases/latest/download/plantuml.jar` |
| Graphviz | DOT graph rendering | `brew install graphviz` |

## Project Files

| File | Description |
|------|-------------|
| `SKILL.md` | Full skill specification: patterns, folder structure, commands, best practices |
| `references/` | Syntax reference for each supported diagram type |
| `templates/` | Starter templates for new projects |

<!-- relux-ecosystem:start -->

## About Relux Works

This project is part of the open-source ecosystem of
[Relux Works](https://relux.works), an AI-native software development studio.
We build fixed-price MVPs, rescue vibe-coded apps, run local AI inference, and
train teams to work with coding agents. Much of the infrastructure behind that
work is open source.

- Full catalog: [relux.works/en/open-source](https://relux.works/en/open-source/)
- Agentic enablement: [agent harnesses & team training](https://relux.works/en/agentic-enablement/)
- Hire us the agent-native way: point your assistant at `https://api.relux.works/mcp`
- Contact: ivan@relux.works

<!-- relux-ecosystem:end -->
