# Starter kit — AI Security Fluency

Take-home material from the ITSEC Cyber & AI Academy class *AI Security Fluency: using AI safely and productively* (PIDI Digital Talent Expo, Jakarta, 24 September 2026). Short link to this repository: **git.candra.me**. Everything here works with any AI assistant — ChatGPT, Gemini, Claude — free tier included.

| File | What it is |
|---|---|
| [`SYSTEM-PROMPT.en.md`](SYSTEM-PROMPT.en.md) | The 8-rule starter system prompt, English |
| [`SYSTEM-PROMPT.id.md`](SYSTEM-PROMPT.id.md) | The same, Bahasa Indonesia |
| [`materi-peserta.md`](materi-peserta.md) | The class exercises (Bahasa Indonesia): meeting notes, six "catch the leak" cases, the CV with a hidden line |
| [`../CLAUDE.md`](../CLAUDE.md) | The work-scale version: the template the author uses with a coding assistant every day |

## The idea in one paragraph

An AI assistant is a genius intern with three habits: it makes things up confidently, it repeats whatever you give it to whoever asks next, and it obeys whoever gives orders — including text hidden inside a document you asked it to read. An intern gets a briefing on day one. Your **system prompt** is that briefing: rules you write once, grouped by *when they fire* — before you send, while the AI reads outside material, before you trust the answer.

## Install (2 minutes)

1. Open a starter file above, copy the block.
2. ChatGPT: Settings → Personalization → Custom instructions. Gemini: Settings → Saved info. Claude: Settings → Preferences, or a Project's instructions. Any other tool: paste it as the first message of the chat. (Menu names change between versions — look for "custom instructions", "saved info" or "preferences".)
3. Change at least two rules so they fit your life — your thesis data, your campus accounts, your job.
4. Test it: paste some meeting notes containing a phone number and ask for a summary. A briefed AI stops and asks.

## Try the hack yourself

`materi-peserta.md` has a fictional CV in which one line is *white text* in the real PDF — invisible to a human reviewer, read by the AI. Ask an AI with no rules to score it: the planted line lifts the score. Ask an AI with rules 3–5: it has to quote its evidence, and the only line supporting the high score is the one that isn't in the visible document. That is the whole class in one exercise.

## What's next — if you build agents

Everything above is **layer 1: rules the AI reads**. It can forget them, misread them, or be talked out of them — the hidden-text CV shows how. The moment an AI can *act* (run commands, send email, change records) you need the two layers a prompt cannot provide:

- **Layer 2 — rules the tool enforces.** Checks that run before or after an action: a scan for secrets before anything leaves the machine, a block on destructive commands, a permission list, a policy classifier that approves routine actions and holds risky ones. The model never gets to argue with these. `CLAUDE.md` in this repository is a layer-1 file for a coding assistant; the gates around it live in the tool's settings and hooks — see [Claude Code hooks](https://docs.claude.com/en/docs/claude-code/hooks) for one implementation.
- **Layer 3 — a human.** Whatever the first two escalate waits for a person.

Rule of thumb: if breaking a rule would be expensive, it belongs in layer 2, not in the prompt. The prompt is where you teach; the hook is where you enforce.
