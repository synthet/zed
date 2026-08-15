---
title: Synth forks — Zed × Warp Hybrid
description: Synth Warp and Synth Zed are commercial-free / local-first. No Drive, no hosted cloud AI, no Pro unlocks. CLI / BYOK / ACP only.
timestamp: 2026-08-15T17:45:00Z
---

# Synth forks

← [Zed × Warp](../README.md)

Both checkouts are **commercial-free, local-first** forks. The hybrid must not depend on paid or proprietary cloud surfaces either product stripped.

| Checkout | Path | Display name | Main package ID | URL scheme |
|----------|------|--------------|-----------------|------------|
| Synth Warp | `D:/Projects/warp` | Synth Warp | `io.github.synthet.Warp` (Warp’s 3-part `AppId` limits extra segments) | **`warposs`** |
| Synth Zed | `D:/Projects/zed` | Synth Zed | **`io.github.synthet.Zed`** | **`synthzed://`** |

Package IDs come from [synthet.github.io](https://synthet.github.io/) (`io.github.synthet.*`). Not `synth.dev`.

Detailed Zed deltas (code paths): `(Zed) docs/architecture/fork-deltas.md` — mirrored wiki cannot link that path; open it in the Zed checkout.

## Synth Warp — removed / disabled

- Billing, credits, upgrades, referrals
- Warp Drive cloud sync
- Hosted Warp-credit AI / cloud Oz as a required backend
- Telemetry sinks (Rudderstack / Sentry), not merely default-off

Warp’s server, Drive backend, and Oz orchestration are **not** in the Warp repository. Default-run binary often `warp-oss`.

## Synth Zed — removed / unwired

Payments are **not** in the Zed client (Stripe/Orb live on zed.dev). The fork strips client upsell chrome and unwires hosted product:

| Removed / unwired | Kept |
|-------------------|------|
| Plan chip, upgrade / trial / account CTAs, `ai_onboarding` marketing | Local editor, LSP, terminal, git |
| Hosted `CloudLanguageModelProvider` (zed.dev models) | BYOK, Copilot, Ollama, ACP, Mercury/Codestral |
| Zeta (`EditPredictionProvider::Zed`); default provider `none` | SSH remotes |
| `CloudWebSearchProvider` | Public extension index |
| Hosted collab UI (channels, calls, live share); settings Collaboration page | `crates/collab` source unused in-tree |
| Silent zed.dev sign-in; title-bar Sign In | GPL + Apache as upstream |
| Telemetry POST + minidump/Sentry + Anthropic analytics upload; privacy toggles | Help → View Telemetry (local events). Not Warp’s Privacy HTTP network log |
| Auto-update from `cloud.zed.dev/releases` | — |

**Do not** stub `UserStore::plan()` to Pro. That would be unlocking against Zed’s servers. Cloud features are removed or unwired, not cracked.

Channel IDs: `io.github.synthet.Zed-Dev` / `-Nightly` / `-Preview`. Windows mutex prefix: `SynthZed-Editor-*`.

## What that means for the hybrid

| Tempting dependency | Reality |
|---------------------|---------|
| Cloud/ambient Warp tasks as session list | Empty or degraded without Warp servers |
| Drive-backed shared objects as transport | Not available |
| Warp credits / usage APIs | Irrelevant |
| Hosted Zed Agent / Zeta / zed.dev web search | Unwired in Synth Zed |
| Zed Pro / trial / account deep-links | UI stripped; do not reintroduce |
| Hosted collab as the multiplayer path | Hidden; prefer SSH or later self-hosted collab |
| `AgentConversationsModel` cloud fields (Warp) | Will not populate usefully |
| CLI agents + OSC 777 plugins | **Durable dual-app source of truth** |
| BYOK / custom inference / ACP | Fine in both forks |

`TabConfigPaneType::Cloud` exists in Warp’s schema; do not require it for Zed layouts. Prefer `terminal` and `agent` (CLI) panes.

Synth Zed keeps upstream **GPL**; Synth Warp stays **AGPL** (+ MIT UI crates). Do not assume a license change. See [Licenses](../licenses.md).

## See also

- [Overview](../overview.md)
- [Licenses](../licenses.md)
- [What not to build](../what-not-to-build.md)
- [CLI agent sessions](../surfaces/cli-agent-sessions.md)
- [Current state](../current-state.md)
