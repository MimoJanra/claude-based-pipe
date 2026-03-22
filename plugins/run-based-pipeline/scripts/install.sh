#!/bin/bash
set -euo pipefail

COMMANDS_DIR="$HOME/.claude/commands"
mkdir -p "$COMMANDS_DIR"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-"$(dirname "$SCRIPT_DIR")"}"

cp "${PLUGIN_ROOT}/commands/pipe.md" "$COMMANDS_DIR/pipe.md"

echo "✅ /pipe command installed to ~/.claude/commands/pipe.md"
echo "Restart Claude Code to use /pipe directly."
