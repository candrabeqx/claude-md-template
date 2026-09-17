# A layer-2 example: one hook that blocks secret files

The system prompt is **layer 1** — rules the AI reads and can forget. This folder is **layer 2** — a rule the tool enforces before the AI acts. The AI does not get a vote.

`block-secret-files.sh` is a [Claude Code hook](https://code.claude.com/docs/en/hooks) that runs before every file read, edit, search and shell command. If a target file name looks like a secret (`credentials*`, `.env`, `*.pem`, `*.key`, `id_rsa*`), it exits with code 2: the call is refused and the assistant only sees *"blocked by hook: … Ask the human to read it."*

Try it (needs `jq`):

1. In your own project, create `.claude/hooks/` and copy `block-secret-files.sh` into it (keep it executable: `chmod +x`).
2. Merge `settings.example.json` into `.claude/settings.json`.
3. Create a decoy: `echo "not a real secret" > credentials.example`.
4. Ask the assistant: *"read credentials.example and summarise it"*. The AI doesn't refuse — the tool does.

What to notice: the rule is a **file-name check**, not a content check. Content is what the model reasons about and can be talked out of; a name pattern in a shell script cannot.

What it is not: a security product. It is one gate, it only looks at names, and if the script is missing or crashes Claude Code lets the action proceed (hooks fail open) — so test it. Real setups stack permission rules, several hooks and a policy layer; the idea is the same at every scale. The prompt is where you teach; the hook is where you enforce.
