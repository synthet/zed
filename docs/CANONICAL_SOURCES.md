---
type: Source-of-Truth Map
title: Canonical Sources
description: Authority map — the single source of truth for each contract, convention, and config in this project.
resource: CANONICAL_SOURCES.md
tags: [docs, governance, authority]
timestamp: 2026-08-17T00:00:00Z
okf_version: 0.1
---

# Canonical sources

Agents and contributors must check this map before inventing API paths, schema names, config keys, or
status values. Fill in the right column as your project grows; the left column is the reusable
question.

| Contract / convention | Source of truth (fill in) |
|-----------------------|---------------------------|
| Always-on coding guidelines | [`../.rules`](../.rules) (Zed Agent first-match) |
| Cursor / Codex engineering guide | [`../AGENTS.md`](../AGENTS.md) |
| Claude orientation | [`../CLAUDE.md`](../CLAUDE.md) |
| Gemini CLI | [`../GEMINI.md`](../GEMINI.md) → `.rules` |
| Instruction-file split (adopt) | [`technical/agent-instruction-files.md`](technical/agent-instruction-files.md) |
| Public API shape | Extension API under [`../crates/extension_api`](../crates/extension_api); user-facing settings in [`src/reference/all-settings.md`](src/reference/all-settings.md) |
| Data model / schema | Settings store [`../crates/settings/src/settings.rs`](../crates/settings/src/settings.rs); content [`../crates/settings_content/src/settings_content.rs`](../crates/settings_content/src/settings_content.rs) |
| Config keys | [`src/reference/all-settings.md`](src/reference/all-settings.md) and [`../crates/settings`](../crates/settings) |
| Status / state enums | Feature flags [`../crates/feature_flags`](../crates/feature_flags); editor/workspace state in those crates |
| Domain vocabulary | [`../AGENTS.md`](../AGENTS.md) architecture table; [`../CONTRIBUTING.md`](../CONTRIBUTING.md) crate map |
| Build / test / lint commands | [`../AGENTS.md`](../AGENTS.md); lint via [`../script/clippy`](../script/clippy) |
| Windows source build | [`../script/windows.ps1`](../script/windows.ps1), [`../script/build-windows.ps1`](../script/build-windows.ps1); wiki [guides/windows-dev.md](guides/windows-dev.md); product [src/development/windows.md](src/development/windows.md) |
| Work queue / tech specs | Local Markdown provider [`../.agent/backlog/items.md`](../.agent/backlog/items.md); contract [project/00-backlog-workflow.md](project/00-backlog-workflow.md); no `specs/` tree |
| Bundled theme attribution | [`../assets/themes/LICENSES`](../assets/themes/LICENSES) (shipped notice); engineering record [`../assets/themes/synthet/PROVENANCE.md`](../assets/themes/synthet/PROVENANCE.md) |
| Product docs | [`src/`](src/) mdBook; docs automation [`AGENTS.md`](AGENTS.md) |
| LLM wiki hub | [`INDEX.md`](INDEX.md); conventions [`WIKI_SCHEMA.md`](WIKI_SCHEMA.md); docs map [`technical/docs-map.md`](technical/docs-map.md) |
| Domain skills | [`.claude/skills/gpui-test`](../.claude/skills/gpui-test), [`zed-cherry-pick`](../.claude/skills/zed-cherry-pick), [`lint-creator`](../.claude/skills/lint-creator) |
| Codex project configuration | [`.codex/config.toml`](../.codex/config.toml) and [`.codex/README.md`](../.codex/README.md) |
| Optional file-search MCP (fff) | [fff repo](https://github.com/dmtrKovalenko/fff); template keys `fff-mcp` / `synth-zed-fff` in [`.cursor/mcp.example.json`](../.cursor/mcp.example.json) |
| CLI tooling skills spec | [`.agent/cli-tools-skills-spec.md`](../.agent/cli-tools-skills-spec.md) |
| CLI install tier order | [`.claude/skills/cli-tools-overview/references/install-tiers.md`](../.claude/skills/cli-tools-overview/references/install-tiers.md) |
| Agent CLI environment (PATH, Cursor restart) | [`.claude/skills/cli-tools-overview/references/agent-environment.md`](../.claude/skills/cli-tools-overview/references/agent-environment.md) |
| Agent assets (rules/commands/skills/agents) | [`ai-workflow/README.md`](ai-workflow/README.md) |
| Safety rules | [`../.agent/SAFETY.md`](../.agent/SAFETY.md) |
| Telemetry sinks (this fork) | [`technical/telemetry.md`](technical/telemetry.md); code [`../crates/client/src/telemetry.rs`](../crates/client/src/telemetry.rs) |
| Wiki conventions | [`WIKI_SCHEMA.md`](WIKI_SCHEMA.md) |


**Rule:** code and the written contract must never disagree. If you change one, change the other in
the same PR (see [`../.agent/workflows/cross_repo_contract_change.md`](../.agent/workflows/cross_repo_contract_change.md)).
