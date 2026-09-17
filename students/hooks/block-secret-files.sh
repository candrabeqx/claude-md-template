#!/usr/bin/env bash
# One layer-2 gate, as a toy you can read in a minute: a Claude Code PreToolUse hook that
# refuses tool calls whose target file name looks like a secret. The model never sees the
# content; it only sees the refusal on stderr. Exit code 2 = block the tool call.
#
# It is deliberately small. It matches file NAMES (credentials*, *.pem, *.key, id_rsa*,
# .env, .env.*) inside Read/Edit/Write/Grep/Glob targets and shell commands, token by
# token. It does not follow globs, symlinks, base64 or "python -c open(...)" — a real
# setup layers permission rules, several hooks and a policy engine on top. The point is
# the mechanism: a rule the model cannot argue with.
#
# Requires jq (brew install jq / apt install jq). If the hook is missing or crashes, Claude
# Code lets the action proceed — a hook that fails open is a hook you must test.
set -euo pipefail
input="$(cat)"
tool="$(printf '%s' "$input" | jq -r '.tool_name // empty')"
case "$tool" in
  Read|Edit|Write|Grep|Glob) target="$(printf '%s' "$input" | jq -r '.tool_input.file_path // .tool_input.path // .tool_input.pattern // empty')" ;;
  Bash)                      target="$(printf '%s' "$input" | jq -r '.tool_input.command // empty')" ;;
  *)                         exit 0 ;;
esac
pattern='^(credentials.*|.*[.]pem|.*[.]key|id_rsa.*|[.]env([.].*)?)$'
# split on whitespace and quotes, look at the basename of every token
for tok in $(printf '%s' "$target" | tr "\"'" '  '); do
  base="${tok##*/}"
  if [[ "$base" =~ $pattern ]]; then
    echo "blocked by hook: '$tok' looks like a secret file. Ask the human to read it." >&2
    exit 2
  fi
done
exit 0
