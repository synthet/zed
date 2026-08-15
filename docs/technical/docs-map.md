---
type: Technical Reference
title: Docs Map
description: Which documentation tree to use — LLM wiki, mdBook, zed-warp, or .agent/.
resource: technical/docs-map.md
tags: [docs, wiki, mdbook]
timestamp: 2026-08-15T17:45:00Z
okf_version: 0.1
---

# Docs map

Parent: [technical/INDEX.md](INDEX.md) · Schema: [WIKI_SCHEMA.md](../WIKI_SCHEMA.md)

| Tree | Path | Use for |
|------|------|---------|
| LLM wiki | `docs/` hubs and taxonomy folders | Agent-oriented orientation; small pages; fork facts |
| Product docs | [`src/`](../src/) (mdBook) | Shipped user/contributor docs. Automation: [AGENTS.md](../AGENTS.md) |
| Design wiki | [`zed-warp/`](../zed-warp/README.md) | Zed × Warp hybrid. Mirrored; not mdBook |
| Zed Agent rules | [`.rules`](../../.rules) | Always-on coding guidelines (Zed Agent first-match). Not the wiki. |
| Claude authoring | [`.claude/`](../../.claude/) | Canonical skills/commands/agents/rules. Mirrors generated. |
| Agent governance | [`.agent/`](../../.agent/) | Safety, inventory, workflow playbooks |

Wiki entry: [INDEX.md](../INDEX.md). mdBook contributor page: [README.md](../README.md). Authority map: [CANONICAL_SOURCES.md](../CANONICAL_SOURCES.md). Instruction-file split: [agent-instruction-files.md](agent-instruction-files.md).

Do not copy `src/` into wiki pages. Link out. Fork deltas: [fork-deltas.md](../architecture/fork-deltas.md). Telemetry sinks: [telemetry.md](telemetry.md).
