# Starter kit — AI Security Fluency

**Mulai di sini →** [`SYSTEM-PROMPT.id.md`](SYSTEM-PROMPT.id.md) (starter 8 aturan) · [`materi-peserta.md`](materi-peserta.md) (halaman kelas) · [`materials/`](materials/) (bahan latihan)

Take-home material from the ITSEC Cyber & AI Academy class *AI Security Fluency: using AI safely and productively* (PIDI Digital Talent Expo, Jakarta, 24 September 2026). Short link to this repository: **git.candra.me**. Everything here works with any AI assistant — ChatGPT, Gemini, Claude — free tier included.

| File | What it is |
|---|---|
| [`SYSTEM-PROMPT.id.md`](SYSTEM-PROMPT.id.md) | **Mulai di sini** — starter system prompt 8 aturan, Bahasa Indonesia |
| [`SYSTEM-PROMPT.en.md`](SYSTEM-PROMPT.en.md) | The same, English |
| [`materi-peserta.md`](materi-peserta.md) | The class page (Bahasa Indonesia): the three rounds, step by step |
| [`materials/`](materials/) | The hands-on files: meeting notes plus a cleaned copy that doubles as the answer key (Round 1), six "catch the leak" documents A–F (Round 2), the CV with a hidden line as .md / .pdf / .docx (Round 3) |
| [`hooks/`](hooks/) | Advanced, optional — Claude Code users only: a working layer-2 hook that blocks secret files before the AI can read them |
| [`../CLAUDE.md`](../CLAUDE.md) | The work-scale version: the template the author uses with a coding assistant every day |

## The idea in one paragraph

An AI assistant is a genius intern with three habits: it makes things up confidently, it repeats whatever you give it to whoever asks next, and it obeys whoever gives orders — including text hidden inside a document you asked it to read. An intern gets a briefing on day one. Your **system prompt** is that briefing: rules you write once, grouped by *when they fire* — before you send, while the AI reads outside material, before you trust the answer.

## Install (2 minutes)

1. Open a starter file above, copy the block.
2. ChatGPT: Settings → Personalization → Custom instructions. Gemini: Settings & help → Personal Intelligence → Instructions for Gemini. Claude: Settings → Account → Instructions for Claude, or a Project's instructions. Any other tool: paste it as the first message of the chat. (Menu names change between versions — look for "custom instructions" or "instructions for …".)
3. Change at least two rules so they fit your life — your thesis data, your campus accounts, your job.
4. Test it: paste some meeting notes containing a phone number and ask for a summary. A briefed AI stops and asks.

## Try the hack yourself

[`materials/ronde-3/cv-rizky-pratama.pdf`](materials/ronde-3/cv-rizky-pratama.pdf) is a fictional CV in which one line is *white text* — invisible to a human reviewer, read by the AI (the paste version is next to it as `.md`). Ask an AI with no rules to score it: the planted line lifts the score. Ask an AI with rules 3–5: it has to quote its evidence, and the only line supporting the high score is the one that isn't in the visible document. That is the whole class in one exercise.

## What's next — if you build agents

Everything above is **layer 1: rules the AI reads**. It can forget them, misread them, or be talked out of them — the hidden-text CV shows how. The moment an AI can *act* (run commands, send email, change records) you need the two layers a prompt cannot provide:

- **Layer 2 — rules the tool enforces.** Checks that run before or after an action: a scan for secrets before anything leaves the machine, a block on destructive commands, a permission list, a policy classifier that approves routine actions and holds risky ones. The model does not get a vote on these — as long as they are configured and tested; a missing hook fails open. `CLAUDE.md` in this repository is a layer-1 file for a coding assistant; the gates around it live in the tool's settings and hooks — [`hooks/`](hooks/) has a working one you can try in two minutes.
- **Layer 3 — a human.** Whatever the first two escalate waits for a person.

Rule of thumb: if breaking a rule would be expensive, it belongs in layer 2, not in the prompt. The prompt is where you teach; the hook is where you enforce.
