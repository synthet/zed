---
type: Technical Reference
title: Crate Map
description: Editor crates from CONTRIBUTING, plus where the hybrid crate map lives.
resource: architecture/crate-map.md
tags: [docs, architecture, crates]
timestamp: 2026-08-15T00:00:00Z
okf_version: 0.1
---

# Crate map

Parent: [architecture/INDEX.md](INDEX.md) · Overview: [system-overview.md](system-overview.md)

This is the editor crate map. Canonical prose: [`../../CONTRIBUTING.md`](../../CONTRIBUTING.md) (Bird's-eye view of Zed).

| Crate | Role |
|-------|------|
| `gpui` | GPU UI building blocks |
| `editor` | `Editor` type, input fields, LSP display |
| `project` | Files, filetree, LSP client |
| `workspace` | Local state, grouped projects |
| `vim` | Vim workflow over `editor` |
| `lsp` | External language-server protocol |
| `language` | Symbols, syntax map |
| `collab` / `rpc` | Collaboration server and messages (hosted collab unwired in this fork) |
| `theme` | Theme system |
| `ui` | Shared components |
| `cli` | CLI that launches the Zed binary |
| `zed` | `main` entry point |

Agent UI, ACP, and terminal crates for the Warp hybrid are listed in [zed-warp/crate-map.md](../zed-warp/crate-map.md), not here.

See also [fork-deltas.md](fork-deltas.md) and [docs-map.md](../technical/docs-map.md).
