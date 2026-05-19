# claude-md-template

An opinionated `CLAUDE.md` template for Claude Code. This is what I actually use day-to-day, with company-specific bits stripped out.

The value here is the **behavioral framework** — phase-grouped rules, explicit tie-breakers, a three-step disclosure pattern for surfacing judgment calls, and a tight testing policy with a narrow exemption table. Take what's useful, throw the rest away.

## What's in here

| File | Purpose |
|---|---|
| `CLAUDE.md` | The template. Drop in `~/.claude/CLAUDE.md`. |

That's it. Single file. No scripts, no rule fragments to install, no OS dependencies.

## Design notes

**Phase-grouped behavior.** Rules are grouped by *when they fire*, not by topic — Intake (message arrives) → Planning (before acting) → Execution (during work) → Approval & Disclosure (surfacing judgment calls) → Housekeeping. The grouping is the point: rules about "what to do when a message arrives" live together, rules about "what to do when you're about to ship" live together. Easier to grep when you remember the moment, not the keyword.

**Tie-breakers come before the rules**, so when two rules conflict you have a deterministic answer instead of a coin flip. The list is short on purpose.

**Three-step disclosure pattern** (pre-action restate → optional pre-action ask for UI semantics → end-of-work disclosure) tries to keep the assistant honest about judgment calls without turning every response into a wall of "FYI"s. The **Skip List** exists so trivial stuff (style, naming, formatter output) doesn't pollute the channel.

**Testing policy is strict** — failing test first for bugs, tests alongside implementation — with a narrow exemption table. Adjust the table if your project genuinely has different exemptions; don't widen it casually.

## Install

```sh
cp CLAUDE.md ~/.claude/CLAUDE.md
```

Claude Code auto-loads `~/.claude/CLAUDE.md`. Done.

## License

MIT — see [LICENSE](LICENSE).
