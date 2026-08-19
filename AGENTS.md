# AGENTS.md

<!-- BEGIN SYNTHET-CODE-FRAMEWORK -->
## Authoring & skill source of truth

- **Canonical** assets are authored under `.claude/` (+ `.agent/`).
- The **`.cursor/`** tree and Codex-native **`.agents/skills/`** + **`.codex/agents/`**
  trees are **generated** by `python scripts/sync_assistant_trees.py` — do not hand-edit
  generated files.
- When you change a skill/command/agent, run the sync and commit all generated mirrors in the
  **same change**.
- Install shared common-skills **globally** (`~/.agents/skills`). An in-repo common-skills
  install into `.agents/skills` is wiped the next time assistant trees are synced.

## Commands

```bash
cargo run
cargo nextest run --workspace --no-fail-fast --no-tests=warn
cargo test --workspace --doc --no-fail-fast
./script/clippy
cargo fmt --all -- --check
./script/prettier
```

See [`.agent/SAFETY.md`](.agent/SAFETY.md) and [`docs/ai-workflow/README.md`](docs/ai-workflow/README.md).

## MCP servers

- Project servers: [`.mcp.json`](.mcp.json) (Claude Code). Copy
  [`.cursor/mcp.example.json`](.cursor/mcp.example.json) → `.cursor/mcp.json` (gitignored) for Cursor.
- Optional fff / Graphify examples live under `_examples` in `.mcp.json` and `.cursor/mcp.example.json`.
- User-level `~/.cursor/mcp.json` holds cross-repo tools.

## Test vocabulary

| You say | Canonical name | Where | How to run |
|---------|----------------|-------|------------|
| unit | crate unit tests | `*_tests.rs` / `#[cfg(test)]` | `cargo nextest run -p <crate>` |
| nextest | workspace nextest | workspace | `cargo nextest run --workspace --no-fail-fast --no-tests=warn` |
| doc | rustdoc tests | `///` examples | `cargo test --workspace --doc --no-fail-fast` |
| gpui | GPUI scheduler tests | `#[gpui::test]` | see `gpui-test` skill |

## RCA / Failure Log

| Date | Symptom | Root cause | Fix / guard |
|------|---------|------------|-------------|
| _(none yet)_ | | | |

## Backlog

Work is claimed from existing **GitHub issues** on [synthet/zed](https://github.com/synthet/zed).
Zed uses Discussions for feature requests and issue templates for bugs; do not invent a parallel
`specs/` tree or `.agent/backlog/items.md`. Provider docs remain under
[`.agent/backlog/`](.agent/backlog/README.md) for optional `/task-claim` use.

<!-- END SYNTHET-CODE-FRAMEWORK -->

This file is the Cursor / Codex engineering guide for **Synth Zed**. Always-on coding guidelines
for Zed Agent live in [`.rules`](.rules) (GPUI, `./script/clippy`, PR hygiene). Gemini CLI still
reads [`GEMINI.md`](GEMINI.md), which remains a `.rules` pointer.

[`CONTRIBUTING.md`](CONTRIBUTING.md) requires a human in the loop who understands the work; this
fork does not accept autonomous-agent PRs.

## `script/` vs `scripts/`

- **`script/`** (singular) — product scripts: `clippy`, `prettier`, `bootstrap`, `cherry-pick`,
  platform setup. Prefer these over raw cargo wrappers when `.rules` or CI does.
- **`scripts/`** (plural) — synthet-code-framework agent tooling (`sync_assistant_trees.py`,
  frontmatter checks, inventory). Do not confuse the two.

## Development commands

### Build and run

- `cargo run` / `cargo run --release` — build and run the editor locally.
- Linux: `./script/linux` for native dependencies before the first build.
- Platform docs: [`docs/src/development/macos.md`](docs/src/development/macos.md),
  [`linux.md`](docs/src/development/linux.md), [`windows.md`](docs/src/development/windows.md).

### Testing

- Fast subset: `cargo nextest run -p <crate>`
- Workspace: `cargo nextest run --workspace --no-fail-fast --no-tests=warn`
- Doc tests: `cargo test --workspace --doc --no-fail-fast`
- GPUI tests: `#[gpui::test]` — reproduce with `SEED` / `ITERATIONS` / `PENDING_TRACES=1`
  (see the `gpui-test` skill). Prefer GPUI executor timers over `smol::Timer`.

### Linting and formatting

- `./script/clippy` (Windows: `./script/clippy.ps1`) — **not** bare `cargo clippy`.
  Runs `cargo clippy --workspace --release --all-targets --all-features -- --deny warnings`.
- `cargo fmt --all -- --check`
- `./script/prettier` — docs and settings JSON
- Also used in CI: `./script/check-todos`, `./script/check-keymaps`, `./script/check-licenses`

## Architecture

Synth Zed is a local-first, commercial-free fork of the Zed editor. GPUI is the GPU UI framework;
the `zed` crate is the binary entry point.

| Module / component | Role |
|--------------------|------|
| `crates/gpui` | GPU-accelerated UI, entities, executor, test harness |
| `crates/editor` | Core `Editor` and LSP display layer |
| `crates/project` | Files, worktree, LSP client side |
| `crates/workspace` | Windows, panes, local state |
| `crates/language` | Languages, syntax, symbols |
| `crates/lsp` | External language-server protocol |
| `crates/ui` | Shared UI components |
| `crates/zed` | Application main |
| `crates/cli` | CLI that launches the Zed binary |
| `tooling/lints` | Workspace dylints (`lint-creator` skill) |

Hosted collab, Zed Pro billing, and telemetry sinks are removed or unwired in this fork. BYOK
LLMs, Copilot, Ollama, ACP, SSH remotes, and the public extension index remain.

## Coding guidelines

Follow [`.rules`](.rules). Do not dump architectural maps into `.rules`; that file is high-signal
traps only. Crate-specific rules belong in that crate's own `.rules` file.

## Documentation

Product docs are mdBook under [`docs/src/`](docs/src/). Automation rules:
[`docs/AGENTS.md`](docs/AGENTS.md). Agent authority map:
[`docs/CANONICAL_SOURCES.md`](docs/CANONICAL_SOURCES.md).
