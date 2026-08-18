---
type: Technical Reference
title: Fork Deltas
description: What Synth Zed removes or keeps relative to upstream Zed (commercial-free, local-first).
resource: architecture/fork-deltas.md
tags: [docs, architecture, fork, synth-zed]
timestamp: 2026-08-17T00:00:00Z
okf_version: 0.1
---

# Fork deltas

Parent: [architecture/INDEX.md](INDEX.md) · Overview: [system-overview.md](system-overview.md)

**Synth Zed** is a local-first, commercial-free fork of [synthet/zed](https://github.com/synthet/zed) (upstream [zed-industries/zed](https://github.com/zed-industries/zed)). Checkout: `D:/Projects/zed`. Display name **Synth Zed**. Main package ID **`io.github.synthet.Zed`** (from [synthet.github.io](https://synthet.github.io/); not `synth.dev`, not `dev.zed.Zed`).

Canonical product README: [`../../README.md`](../../README.md). Hybrid constraints (both forks): [zed-warp/constraints/synth-fork.md](../zed-warp/constraints/synth-fork.md).

## Decisions (settled)

1. Strip Pro / upgrade / trial UI **and** go local-first (remove monetization chrome **and** zed.dev-hosted product surfaces).
2. Hide hosted collab (channels, calls, live share). Keep SSH remotes. Leave `crates/collab` in-tree unused.
3. Kill telemetry **sinks** (not merely default-off). Contract: [telemetry.md](../technical/telemetry.md).
4. Do **not** stub `UserStore::plan()` to Pro — that would unlock against Zed’s servers. Cloud features are unwired, not cracked.

v1 explicitly does **not** include: a replacement zed.dev account server, renaming every `zed_*` crate, making hosted Zed models / Zeta work without Zed’s backend, or full trademark-clean icon replacement beyond display name / scheme / bundle IDs.

## Removed or unwired

| Area | What changed |
|------|----------------|
| Monetization UI | Plan chip, upgrade / trial / account CTAs, `ai_onboarding` plan marketing, `end_trial_upsell`, jobs/merch links |
| Hosted Zed AI | Stop registering `CloudLanguageModelProvider`; no Zed-hosted completions |
| Zeta / edit preds | Hide `EditPredictionProvider::Zed` from picker; default `"edit_predictions.provider": "none"` |
| Zed web search | Do not register `CloudWebSearchProvider` |
| Collab | Collab panel not loaded into dock; Collaboration settings page omitted from settings nav |
| Auth | No silent `sign_in_with_optional_connect`; title-bar `"show_sign_in": false`; onboarding Sign In / account / trial dropped |
| Telemetry | No `POST /telemetry/events` (`flush_events_inner` local log only; dead POST builder removed); no minidump / Sentry / Anthropic-analytics upload; defaults `diagnostics`/`metrics` **false**; privacy toggles hidden. Help → View Telemetry is **events**, not Warp’s HTTP network log. |
| Auto-update | `"auto_update": false` (do not pull `cloud.zed.dev/releases`) |

There is **no** in-app Billing settings page and no Stripe/Orb in this repo — payments live on zed.dev. Client only showed plan mirroring and deep-links; those CTAs are gone.

## Kept

- Local editor, LSP, terminal, git, debugger
- SSH remotes (`crates/remote`, `remote_server`)
- BYOK providers (Anthropic, OpenAI, Ollama, LM Studio, OpenRouter, Bedrock, …), Copilot Chat, ChatGPT subscription client, Mercury / Codestral edit prediction, ACP / external agents
- Public extension index (`api.zed.dev/extensions` — free OSS catalog)
- Upstream **GPL-3.0-or-later** + Apache-2.0 where marked (not a license change)
- `crates/collab` / `collab_ui` source left in-tree for possible later self-host; unwired from default UX

## Themes

The fork ships **35 bundled theme variants under 35 distinct names** — Zed's original 11 (Ayu,
Gruvbox, One) plus 24 added under [`assets/themes/synthet/`](../../assets/themes/synthet/) in three
provenance groups: MIT (Nord, Catppuccin Mocha, GitHub Dark Default), Apache-2.0 (16 from
`warpdotdev/themes`, plus Tokyo Night and JetBrains Darcula), and AGPL-3.0-only (Adeberry,
Phenomenon, Solar Flare, which applies to those three files only).

The shipped end-user notice is [`assets/themes/LICENSES`](../../assets/themes/LICENSES) — it is
concatenated into the generated `assets/licenses.md` behind `zed: open licenses`, so any theme added
or removed must be reflected there. The engineering record (pinned upstream SHAs, per-theme
verification results, documented palette adaptations) is
[`assets/themes/synthet/PROVENANCE.md`](../../assets/themes/synthet/PROVENANCE.md), which is a repo
doc and deliberately excluded from the binary. `crates/theme_settings/tests/synthet_default_themes.rs`
asserts the name set and that nothing but `.json` is embedded under `themes/`.

## Identifiers

| Surface | Value |
|---------|--------|
| Stable / main package | `io.github.synthet.Zed` |
| Channels | `io.github.synthet.Zed-Dev`, `-Nightly`, `-Preview` |
| Windows mutex / pipe | `SynthZed-Editor-{Dev,Nightly,Preview,Stable}` |
| Windows Appx Identity | `io.github.synthet.Zed` (+ Preview/Nightly) |
| URL scheme | `synthzed://` (was `zed://`) |
| Display names | Synth Zed / Dev / Nightly / Preview |

Sources: [`crates/release_channel/src/lib.rs`](../../crates/release_channel/src/lib.rs), [`crates/zed/Cargo.toml`](../../crates/zed/Cargo.toml) bundle metadata, [`assets/settings/default.json`](../../assets/settings/default.json).

## Windows build note

Official builds expect Spectre-mitigated MSVC libs. This fork patches `msvc_spectre_libs` to [`tooling/msvc_spectre_libs_stub`](../../tooling/msvc_spectre_libs_stub) so local `cargo check` / `cargo build` can proceed without that VS component. Prefer installing the real Spectre libs for release builds.

`script/windows.ps1 -Check` still **fails** when `Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre` is missing. Bypass that check and compile with the stub, or install the component. Scripts, resume, and cargo locks: [windows-dev.md](../guides/windows-dev.md). Snapshot: [windows-build-2026-08-15.md](../reports/windows-build-2026-08-15.md).

## Hard limits (do not “fix”)

- Do not unlock hosted Zed AI / Zeta / collab against `cloud.zed.dev` / `collab.zed.dev`
- Do not stub entitlements to Pro / unlimited credits
- Do not depend on Warp Drive / hosted Warp AI either — see [synth-fork](../zed-warp/constraints/synth-fork.md)

Work comes from the Local Markdown backlog at [`../../.agent/backlog/items.md`](../../.agent/backlog/items.md) — GitHub Issues and Discussions are disabled on [synthet/zed](https://github.com/synthet/zed). No autonomous-agent PRs ([`../../CONTRIBUTING.md`](../../CONTRIBUTING.md)). Docs split: [docs-map.md](../technical/docs-map.md). Agent files after framework adopt: [agent-instruction-files.md](../technical/agent-instruction-files.md).
