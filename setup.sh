#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="architecture-diagrams"
SKILL_DIR="$(cd "$(dirname "$0")" && pwd)"

AGENTS_DIR="$HOME/.agents/skills"
CLAUDE_DIR="$HOME/.claude/skills"
CODEX_DIR="$HOME/.codex/skills"

echo "Installing skill: $SKILL_NAME"
echo "  Source: $SKILL_DIR"

# 1. Stage a clean copy of the skill. In a git checkout this is the committed
#    HEAD only, so untracked or ignored local files (.temp/, .agents/, .claude/,
#    .codex/, AGENTS.md, task-board.config.json, ...) never reach the installed copy.
STAGE_DIR="$(mktemp -d)"
trap 'rm -rf "$STAGE_DIR"' EXIT

if [ "$(git -C "$SKILL_DIR" rev-parse --show-toplevel 2>/dev/null)" = "$SKILL_DIR" ]; then
  if [ -n "$(git -C "$SKILL_DIR" status --porcelain --untracked-files=no)" ]; then
    echo "  WARN: uncommitted changes are not installed; only HEAD is."
  fi
  git -C "$SKILL_DIR" archive --format=tar HEAD | tar -x -C "$STAGE_DIR"
else
  # Not a git checkout (e.g. a downloaded archive): copy, skipping local-only files.
  rsync -a "$SKILL_DIR/" "$STAGE_DIR/" \
    --exclude='.git' --exclude='.temp' --exclude='.agents' --exclude='.claude' \
    --exclude='.codex' --exclude='.local' --exclude='AGENTS.md' \
    --exclude='task-board.config.json' --exclude='.task-board'
fi

# 2. Copy skill into .agents/skills/ (installed copy, not a symlink)
if [ -L "$AGENTS_DIR/$SKILL_NAME" ]; then
  rm -f "$AGENTS_DIR/$SKILL_NAME"
fi
mkdir -p "$AGENTS_DIR/$SKILL_NAME"
rsync -a --delete --delete-excluded "$STAGE_DIR/" "$AGENTS_DIR/$SKILL_NAME/" --exclude='setup.sh'
echo "  Copied -> $AGENTS_DIR/$SKILL_NAME/"

# 3. Symlink from .claude/skills/ -> .agents/skills/
mkdir -p "$CLAUDE_DIR"
rm -f "$CLAUDE_DIR/$SKILL_NAME"
ln -s "$AGENTS_DIR/$SKILL_NAME" "$CLAUDE_DIR/$SKILL_NAME"
echo "  Symlink -> $CLAUDE_DIR/$SKILL_NAME"

# 4. Symlink from .codex/skills/ -> .agents/skills/
mkdir -p "$CODEX_DIR"
rm -f "$CODEX_DIR/$SKILL_NAME"
ln -s "$AGENTS_DIR/$SKILL_NAME" "$CODEX_DIR/$SKILL_NAME"
echo "  Symlink -> $CODEX_DIR/$SKILL_NAME"

echo ""
echo "Done. Installed $(git -C "$SKILL_DIR" describe --tags --always 2>/dev/null || echo 'unknown')"
