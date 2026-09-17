#!/usr/bin/env bash
# Layer 2 in one file: a Claude Code PreToolUse hook that refuses to read or print files
# that usually hold secrets, no matter what the prompt says. The model never sees the
# content; it only sees the refusal on stderr. Exit code 2 = block the tool call.
#
# Blocks: credentials*, *.pem, *.key, id_rsa*, .env and .env.* — in Read and in shell
# commands (cat/less/head/tail/sed/awk/grep on those paths). Extend the pattern to taste;
# keep it a denylist of file names, not of words — content inspection is what the
# model does, this layer must not depend on it.
set -euo pipefail
input="$(cat)"
tool="$(printf '%s' "$input" | sed -n 's/.*"tool_name":"\([^"]*\)".*/\1/p')"
target=""
case "$tool" in
  Read)  target="$(printf '%s' "$input" | sed -n 's/.*"file_path":"\([^"]*\)".*/\1/p')" ;;
  Bash)  target="$(printf '%s' "$input" | sed -n 's/.*"command":"\(.*\)".*/\1/p')" ;;
  *)     exit 0 ;;
esac
pattern='(credentials[^ "/]*|[^ "/]*\.pem|[^ "/]*\.key|id_rsa[^ "/]*|\.env(\.[^ "/]*)?)'
if printf '%s' "$target" | grep -Eq "(^|/)$pattern(\"|$| )"; then
  echo "blocked by hook: '$target' looks like a secret file. Ask the human to read it." >&2
  exit 2
fi
exit 0
