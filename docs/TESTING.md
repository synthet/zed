---
type: Documentation Hub
title: Testing
description: Test vocabulary and where GPUI scheduler tests are documented.
resource: TESTING.md
tags: [docs, testing, hub]
timestamp: 2026-08-15T00:00:00Z
okf_version: 0.1
---

# Testing

Thin hub. The command table in [`../AGENTS.md`](../AGENTS.md) is canonical.

| You say | How to run |
|---------|------------|
| unit | `cargo nextest run -p <crate>` |
| nextest | `cargo nextest run --workspace --no-fail-fast --no-tests=warn` |
| doc | `cargo test --workspace --doc --no-fail-fast` |
| gpui | `#[gpui::test]` — see the [`gpui-test`](../.claude/skills/gpui-test/SKILL.md) skill |

Prefer GPUI executor timers over `smol::Timer`. Reproduce flakes with `SEED` / `ITERATIONS` / `PENDING_TRACES=1`.

See also [DEVELOPMENT.md](DEVELOPMENT.md) and [guides/local-build.md](guides/local-build.md).
