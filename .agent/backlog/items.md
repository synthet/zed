# Synth Zed backlog

Active backlog for this fork, using the [Local Markdown provider](providers/local-markdown.md).
GitHub Issues and Discussions are disabled on `synthet/zed`, so this file is the system of record.

Statuses: `Backlog`, `Ready`, `Claimed`, `In Progress`, `Blocked`, `Review`, `Done`.
Claim by setting `Owner` and `Status`; reference the ID in the PR body (`Refs L-001`).
Move completed items to `archive.md` if this list grows too large.

Scope note: this list is **fork-owned work only**. The 281 inherited upstream `TODO`/`FIXME`/`HACK`
markers under `crates/` are excluded by decision — they belong to upstream Zed.

## Items

| ID | Status | Priority | Owner | Title | Notes |
|----|--------|----------|-------|-------|-------|
| L-001 | Done | p1 | - | Add missing LICENSE symlink to `msvc_spectre_libs_stub` | `script/check-licenses` requires a `LICENSE-GPL`/`LICENSE-APACHE` symlink in every dir with a `Cargo.toml`; `tooling/msvc_spectre_libs_stub` was the only one missing it, so CI (`run_tests.yml:796`) would fail on Linux. Regression from `2a60ab4b75`. Fixed by staging `LICENSE-APACHE` with mode `120000` (blob matches the 41 depth-2 peers). |
| L-002 | Blocked | p2 | - | Commit and verify the Synthet theme bundle | 32 theme JSONs under `assets/themes/synthet/`, a new `crates/theme_settings/tests/synthet_default_themes.rs` asserting 43 bundled themes, and an `assets` dev-dep in `crates/theme_settings/Cargo.toml` + `Cargo.lock`. Wiring is sound: `crates/assets` already embeds `themes/**/*` and `load_bundled_themes` walks recursively. Never built, never run. Unblock condition: L-003 and L-004 decided. Then `cargo nextest run -p theme_settings`. |
| L-003 | Ready | p1 | - | Decide: AGPL-derived Warp theme adaptations vs. anti-AGPL policy | `script/check-licenses` `check_no_agpl_license_file()` states first-party code must use `LICENSE-GPL` or `LICENSE-APACHE`. The pending bundle adds `assets/themes/synthet/LICENSE-AGPL-3.0`, and `warp-defaults/` are adaptations of `AGPL-3.0-only` Warp source. It evades the guard only because the guard globs `*/LICENSE-AGPL` and the file is suffixed `-3.0` — coincidence, not compliance. Options: drop `warp-defaults/`, re-derive from non-AGPL sources, or amend the policy. Owner decision, not an agent decision. Blocks L-002. |
| L-004 | Ready | p1 | - | Decide: redistributing the Monokai Pro theme | `assets/themes/synthet/PROVENANCE.md` states the public Monokai Pro repo describes a proprietary commercial theme and publishes no license. Decide whether `popular-dark/monokai-pro.json` ships. Blocks L-002. |
| L-005 | Backlog | p3 | - | Fold Synthet theme attribution into `assets/themes/LICENSES` | Existing bundled themes aggregate attribution in `assets/themes/LICENSES`; the Synthet bundle introduced a parallel `PROVENANCE.md`. Fold whatever survives L-003/L-004 into the established file. |
| L-006 | Backlog | p3 | - | Stop embedding non-theme files in the binary | `#[include = "themes/**/*"]` in `crates/assets/src/assets.rs` embeds `PROVENANCE.md` and `LICENSE-AGPL-3.0`. Harmless at runtime (`load_bundled_themes` filters `.json`) but dead bytes. Add an `#[exclude]` or move the docs out of `assets/`. |
| L-007 | Backlog | p3 | - | Document the Synthet theme catalog | No mention in `docs/architecture/fork-deltas.md`, and no `docs/log.md` entry — the repo treats that log as an append-only record of every wiki/asset change. |
| L-008 | Done | p1 | - | Sync local `main` with `origin/main` | Local was 3 commits behind: `36c8be5338` (merge of `zed-industries/main`), `56b1e79a55`, `1e3d8b5a66`. Fast-forwarded; now level with origin. |
| L-009 | Done | p2 | - | Remove stale cargo-check scratch logs | Three untracked Aug-14 logs sat in the repo root, unmatched by `.gitignore`. Deleted, and `cargo-check-*.log` added to `.gitignore`. The `msvc_spectre_libs` failure they recorded was already fixed by the `Cargo.toml:981` stub patch. |
| L-010 | Done | p2 | - | Fix the backlog provider contradiction in `CLAUDE.md` | It named GitHub Issues as the sole work source (disabled on the repo) and forbade `.agent/backlog/items.md` (the provider now in use). Rewritten to point at this file and the Local Markdown provider. |
| L-011 | Ready | p3 | - | Update the `synthet/zed` GitHub repo description | Still upstream Zed's: "high-performance, multiplayer code editor from the creators of Atom and Tree-sitter". Wrong branding, and "multiplayer" contradicts the fork's local-first stance. Repo-settings change, owner-only. |
| L-012 | Backlog | p3 | - | Prune inherited upstream GitHub workflows | All 46 files in `.github/workflows/` reference `zed-industries`, collab, or org secrets this fork does not hold — `deploy_collab`, `bump_collab_staging`, `guild_*`, `triage_*`, `community_*`, `slack_notify_*`, duplicate-bot. Dead weight or noisy failures, and they contradict "strip hosted commercial surfaces". Plausible keepers: `run_tests`, `release*`, `nix_build`, `run_bundling`. |
| L-013 | Backlog | p3 | - | Reconcile telemetry/collab crates with the documented fork deltas | `crates/telemetry`, `crates/telemetry_events`, `crates/collab`, `crates/collab_ui` still exist while `CLAUDE.md` claims the fork removes hosted zed.dev collaboration and telemetry sinks. `89147dac6d` only documented the sinks. Decide whether present-but-inert is the intended end state (then soften the wording) or removal is still outstanding. |
| L-014 | Backlog | p3 | - | Re-verify dead code in fork-touched files | An Aug-14 check flagged `crates/language_models/src/provider/anthropic/telemetry.rs:32,42` (`as_str` never used) and an unused `user_store` param in `crates/onboarding` `render_ai_section` — plausibly orphaned by the commercial-surface strip. Evidence predates several commits; re-run a check before acting. |
