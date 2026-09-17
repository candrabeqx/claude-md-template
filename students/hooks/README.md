# A layer-2 example: a hook that blocks secret files

The system prompt is **layer 1** — rules the AI reads and can forget. This folder is **layer 2** — a rule the tool enforces before the AI acts, with no argument possible.

`block-secret-files.sh` is a [Claude Code hook](https://docs.claude.com/en/docs/claude-code/hooks) that runs before every `Read` and every shell command. If the target looks like a secret file (`credentials*`, `.env`, `*.pem`, `*.key`, `id_rsa*`), it exits with code 2: the call is refused and the assistant only sees the message *"blocked by hook: … Ask the human to read it."*

Try it:

1. Copy `settings.example.json` into your project's `.claude/settings.json` (merge the `hooks` key if you already have one) and keep the script path.
2. Create a decoy: `echo "not a real secret" > credentials.example`.
3. Ask the assistant: *"read credentials.example and summarise it"*. The AI doesn't refuse — the tool does.

What to notice: the rule is a **file-name denylist**, not a content check. Content is what the model reasons about and can be talked out of; a name pattern in a shell script cannot. That is the difference between the two layers.

The same idea exists in every serious tool: permission lists, policy engines, DLP scanners. The prompt is where you teach; the hook is where you enforce.
