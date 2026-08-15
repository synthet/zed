---
type: Technical Reference
title: Telemetry (Synth Zed)
description: Core product telemetry, crash upload, and Anthropic analytics stay on-box. Warp’s Privacy network log is a different feature and is not in this fork.
resource: technical/telemetry.md
tags: [docs, telemetry, privacy, local-first]
timestamp: 2026-08-15T17:45:00Z
okf_version: 0.1
---

# Telemetry (Synth Zed)

Parent: [technical/INDEX.md](INDEX.md) · Fork deltas: [fork-deltas.md](../architecture/fork-deltas.md)

This fork **kills telemetry sinks**, not merely default-off settings. Help → **View Telemetry** (`zed::OpenTelemetryLog`) is a **local event log**, not an outbound HTTP console.

Upstream product write-up [`src/telemetry.md`](../src/telemetry.md) still describes shipping to Sentry / Snowflake / Amplitude. Treat that page as **stale for this fork**; this wiki page is the contract.

## Not Warp’s network log

Warp Privacy → **View network logging** captures **HTTP request/response** items (in-memory ring, last 50, read-only pane). Synth Zed does **not** have that UI. Zed’s `http_client` has no before/after request hooks.

Do **not** copy Warp’s AGPL network-log sources into Zed ([what-not-to-build](../zed-warp/what-not-to-build.md)). A port would be a new issue: hooks on Zed’s client, a bounded in-memory ring, a read-only editor tab.

## Core sinks (local-only)

These paths do not POST off the machine:

| Path | Behavior |
|------|----------|
| [`crates/client/src/telemetry.rs`](../../crates/client/src/telemetry.rs) `flush_events_inner` | Drain queue; may write `telemetry.log`. No `POST /telemetry/events`. Dead `build_request` removed. |
| `telemetry::event!` producers (hangs, latency, onboarding, agent UI, …) | Same queue. Dropped when `telemetry.metrics` is false. |
| [`crates/zed/src/reliability.rs`](../../crates/zed/src/reliability.rs) | `upload_previous_minidumps` and `upload_build_timings` return `Ok(())`. |
| [`crates/language_models/src/provider/anthropic/telemetry.rs`](../../crates/language_models/src/provider/anthropic/telemetry.rs) | `send_anthropic_event` is a no-op. |
| Settings | `diagnostics` / `metrics` / `anthropic_retention` default **false** in [`assets/settings/default.json`](../../assets/settings/default.json) and `TelemetrySettingsContent`. Privacy toggles hidden in settings UI. |

Regression: `test_telemetry_flush_does_not_send_http` in `crates/client/src/telemetry.rs` (enable metrics, flush, assert zero HTTP). `cargo nextest` may be missing on a workstation; `cargo test -p client --lib telemetry` is the fallback.

## Local artifacts (not uploads)

- `Help → View Telemetry` — [`crates/zed/src/zed/telemetry_log.rs`](../../crates/zed/src/zed/telemetry_log.rs)
- Optional `telemetry.log` under the logs dir
- Crash `.dmp` / `.json` sidecars if the crash handler is installed (`ZED_GENERATE_MINIDUMPS` or a baked `ZED_MINIDUMP_ENDPOINT` on non-Dev). **Upload is stubbed.**
- Hang traces `hang-*.miniprof.json` (local)

## Out of this contract

Still can leave the machine **if the user uses that feature**. Not the `/telemetry/events` sink:

- BYOK / Copilot / Mercury **inference**
- Mercury accept/reject **feedback** (`api-feedback.inceptionlabs.ai`)
- Zeta `/predict_edits/reject` and `/settled` if that provider is enabled (default `"edit_predictions.provider": "none"`)
- User-initiated agent / edit-prediction **feedback POSTs** to `cloud.zed.dev` if signed in
- Auto-update GET may attach `system_id` / `metrics_id` **only if** both auto-update and metrics are on (defaults off)
- Public extension index catalog GET (no telemetry IDs)
- Collab **server** `/telemetry/*` routes exist in `crates/collab` but are not the editor binary

Hosted Zed AI / web search providers are not registered ([fork-deltas.md](../architecture/fork-deltas.md)).
