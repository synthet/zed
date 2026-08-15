---
type: Technical Reference
title: System Overview
description: GPUI, the zed binary, and the crates agents touch first.
resource: architecture/system-overview.md
tags: [docs, architecture]
timestamp: 2026-08-15T00:00:00Z
okf_version: 0.1
---

# System overview

Parent: [architecture/INDEX.md](INDEX.md) · Hub: [ARCHITECTURE.md](../ARCHITECTURE.md)

GPUI is the GPU UI framework. The `zed` crate is the application entry point.

| Crate | Role |
|-------|------|
| `crates/gpui` | GPU-accelerated UI, entities, executor, `#[gpui::test]` |
| `crates/editor` | Core `Editor` and LSP display layer |
| `crates/project` | Files, worktree, LSP client side |
| `crates/workspace` | Windows, panes, local state |
| `crates/language` | Languages, syntax, symbols |
| `crates/ui` | Shared UI components |
| `crates/zed` | Application main |
| `tooling/lints` | Workspace dylints |

Canonical orientation: [`../../CLAUDE.md`](../../CLAUDE.md). Crate list: [crate-map.md](crate-map.md). Fork vs upstream: [fork-deltas.md](fork-deltas.md). Hybrid crates: [zed-warp/crate-map.md](../zed-warp/crate-map.md).
