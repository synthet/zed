---
type: Documentation Hub
title: Development
description: Where to look for build, lint, and platform setup in this checkout.
resource: DEVELOPMENT.md
tags: [docs, development, hub]
timestamp: 2026-08-15T17:30:00Z
okf_version: 0.1
---

# Development

Thin hub. Commands live in [`../AGENTS.md`](../AGENTS.md). How-tos live in [`guides/`](guides/INDEX.md).

- [local-build.md](guides/local-build.md) — `cargo run`, clippy, nextest
- [windows-dev.md](guides/windows-dev.md) — Windows scripts, Spectre stub, resume
- [TESTING.md](TESTING.md) — test vocabulary
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) — Windows/build pointers
- [agent-instruction-files.md](technical/agent-instruction-files.md) — `.rules` vs guides; `script/` vs `scripts/`

Product **`script/`** (clippy, prettier) is not framework **`scripts/`** (sync, inventory). Shipped contributor docs: [src/development.md](src/development.md). mdBook automation: [AGENTS.md](AGENTS.md).
