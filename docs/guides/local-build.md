---
type: Guide
title: Local Build
description: Build, lint, and test commands for this checkout.
resource: guides/local-build.md
tags: [docs, guides, build]
timestamp: 2026-08-15T17:30:00Z
okf_version: 0.1
---

# Local build

Parent: [guides/INDEX.md](INDEX.md) · Hub: [DEVELOPMENT.md](../DEVELOPMENT.md)

Canonical commands: [`../../AGENTS.md`](../../AGENTS.md). Prefer `script/` (singular) over raw cargo wrappers when `.rules` or CI does. Framework tooling is `scripts/` (plural) — see [agent-instruction-files.md](../technical/agent-instruction-files.md).

```bash
cargo run
cargo nextest run --workspace --no-fail-fast --no-tests=warn
cargo test --workspace --doc --no-fail-fast
./script/clippy
cargo fmt --all -- --check
./script/prettier
```

Fast subset: `cargo nextest run -p <crate>`. Prefer `./script/clippy` (Windows: `./script/clippy.ps1`) over bare `cargo clippy`.

Linux native deps before the first build: `./script/linux`. Windows analog: `script/windows.ps1` then `script/build-windows.ps1` ([windows-dev.md](windows-dev.md)). Platform pages: [src/development.md](../src/development.md).

Tests: [TESTING.md](../TESTING.md).
