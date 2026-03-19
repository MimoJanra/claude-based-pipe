#!/bin/bash
set -euo pipefail

COMMANDS_DIR="$HOME/.claude/commands"
mkdir -p "$COMMANDS_DIR"

cp "${CLAUDE_PLUGIN_ROOT}/commands/pipe.md" "$COMMANDS_DIR/pipe.md"

echo "✅ /pipe command installed to ~/.claude/commands/pipe.md"
echo "Restart Claude Code to use /pipe directly."
