# Synth Zed — Local-first fork of the Zed editor

> Agent orientation for this checkout. Engineering commands live in [`AGENTS.md`](AGENTS.md).
> Always-on Zed Agent coding guidelines live in [`.rules`](.rules). Run
> `python scripts/sync_assistant_trees.py` after editing `.claude/` assets; it updates Cursor
> and Codex mirrors.

## Related Projects

| Project | Repository | Role |
|---------|------------|------|
| Synth Zed (this) | https://github.com/synthet/zed | Local-first Zed editor fork |
| synthet-code-framework | sibling `../synthet-code-framework` | Agent scaffold this repo adopted |
| Upstream Zed | https://github.com/zed-industries/zed | Upstream editor |

## Backlog & queue

Work comes from **GitHub issues** on [synthet/zed](https://github.com/synthet/zed). Feature
requests stay in GitHub Discussions; bugs use the issue templates. Do not invent items in
`.agent/backlog/items.md` or a parallel `specs/` tree. Optional `/task-claim` docs remain under
[`.agent/backlog/`](.agent/backlog/README.md).

[`CONTRIBUTING.md`](CONTRIBUTING.md) requires a human in the loop. Do not open autonomous-agent PRs.

## Architecture

GPUI is the GPU UI framework. The `zed` crate is the binary entry point. This fork removes Zed Pro
billing UI, hosted zed.dev collaboration, and telemetry sinks; BYOK / Copilot / Ollama / ACP remain.

| Module / component | Role |
|--------------------|------|
| `crates/gpui` | GPU-accelerated UI, entities, executor, `#[gpui::test]` |
| `crates/editor` | Core `Editor` and LSP display layer |
| `crates/project` | Files, worktree, LSP client side |
| `crates/workspace` | Windows, panes, local state |
| `crates/language` | Languages, syntax, symbols |
| `crates/ui` | Shared UI components |
| `crates/zed` | Application main |
| `tooling/lints` | Workspace dylints |

## Key Files

- [`.rules`](.rules) — Zed Agent always-on coding guidelines (first-match for Zed Agent)
- [`AGENTS.md`](AGENTS.md) — build/test/lint commands and Cursor/Codex engineering guide
- [`GEMINI.md`](GEMINI.md) — still a `.rules` pointer for Gemini CLI
- [`docs/CANONICAL_SOURCES.md`](docs/CANONICAL_SOURCES.md) — authority map
- [`.agent/SAFETY.md`](.agent/SAFETY.md) — safety rules
- `.claude/skills/` — canonical skills (framework + Synth Zed domain). Mirrors: `.cursor/skills/`, `.agents/skills/`

Author Zed skills under `.claude/skills/` next to framework skills, then sync. Product `script/`
(singular) is not the framework `scripts/` tree.

## Commands

```bash
cargo run
cargo nextest run --workspace --no-fail-fast --no-tests=warn
cargo test --workspace --doc --no-fail-fast
./script/clippy
cargo fmt --all -- --check
./script/prettier
```

Fast subset: `cargo nextest run -p <crate>`. Prefer `./script/clippy` over bare `cargo clippy`.

## Testing

| You say | Canonical name | Where | How to run |
|---------|----------------|-------|------------|
| unit | crate unit tests | `*_tests.rs` / `#[cfg(test)]` | `cargo nextest run -p <crate>` |
| nextest | workspace nextest | workspace | `cargo nextest run --workspace --no-fail-fast --no-tests=warn` |
| doc | rustdoc tests | `///` examples | `cargo test --workspace --doc --no-fail-fast` |
| gpui | GPUI scheduler tests | `#[gpui::test]` | `gpui-test` skill |

## Tool permissions and write access

- **Default read-only mode:** the scaffolded `.claude/settings.json` only allows read-oriented inspection (`git status`, `git diff:*`, `git log:*`) plus `WebSearch`.
- **Local writes are opt-in:** to let an agent stage or commit local changes, copy or merge `.claude/settings.write.example.json` into the active Claude settings for that workspace, preferably enabling only the entries needed for the current task.
- **Remote writes are separate:** GitHub mutations through `gh pr:*`, `gh issue:*`, or `gh project:*` affect shared remote state and may notify people; enable them only after explicit task intent and target verification.
- **External export approval:** exporting code, prompts, logs, or generated artifacts to external services/providers requires explicit approval and a secrets check, even when local writes are already allowed.

## Development Guidelines

Follow [`.rules`](.rules) for Rust/GPUI style, timers in tests, and PR hygiene. Additional scaffold rules:

- **Minimal diffs** — prefer targeted edits over rewrites; no drive-by refactors.
- **Secrets** go in `secrets.json` / `.env` (git-ignored), never in committed config.
- **Never modify `.git/config`**.
- Do not casually edit `.rules`; suggest additions in the PR instead (see Rules Hygiene in `.rules`).

## Documentation

Start with [`docs/CANONICAL_SOURCES.md`](docs/CANONICAL_SOURCES.md). Product docs are mdBook under
[`docs/src/`](docs/src/); follow [`docs/AGENTS.md`](docs/AGENTS.md) for docs automation.

- [`AGENTS.md`](AGENTS.md) — commands, MCP, agent contract
- [`docs/ai-workflow/README.md`](docs/ai-workflow/README.md) — agent asset map + SDLC loop
- [`.agent/SAFETY.md`](.agent/SAFETY.md) — safety & hygiene rules
- [`.agent/AGENT_INFRA_INVENTORY.md`](.agent/AGENT_INFRA_INVENTORY.md) — full agent-infra inventory
