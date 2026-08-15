---
type: Documentation Hub
title: Troubleshooting
description: Windows and local-build pointers for this checkout.
resource: TROUBLESHOOTING.md
tags: [docs, troubleshooting, hub]
timestamp: 2026-08-15T17:00:00Z
okf_version: 0.1
---

# Troubleshooting

Thin hub. Start with the platform page, then the wiki guide.

- Windows build: [src/development/windows.md](src/development/windows.md) and [guides/windows-dev.md](guides/windows-dev.md)
- Local `cargo` / clippy / nextest: [guides/local-build.md](guides/local-build.md)
- Tests and GPUI flakes: [TESTING.md](TESTING.md)
- 2026-08-15 Windows compile snapshot: [reports/windows-build-2026-08-15.md](reports/windows-build-2026-08-15.md)

## Windows (this checkout)

| Symptom | What to do |
|---------|------------|
| `windows.ps1 -Check` missing Spectre component | Expected if Spectre libs are not installed. This fork’s [`msvc_spectre_libs` stub](architecture/fork-deltas.md) still lets `cargo build -p zed` run. Install the real VS Spectre component for release. |
| `cargo` exit `-1` / `0xFFFFFFFF`, no rustc error | Process killed or OOM. Re-run; incremental cache under `target/debug/incremental` resumes. Do not `cargo clean`. |
| `Blocking waiting for file lock on build directory` | Another Cargo on this repo (often rust-analyzer `cargo check -p zed`). Wait. |
| `Blocking waiting for file lock on package cache` | Another Cargo using the same `CARGO_HOME` (observed: Warp in `D:/Projects/warp`). Wait; do not kill the sibling build. |
| Linker `LNK4217` or garbled “creating library” text | Warning. Non-Latin `lc_messages` also garbles MSVC linker stdout. |
| Path too long | `git config --global core.longpaths true`. HKLM `LongPathsEnabled` needs an **elevated** PowerShell and a reboot. |
| Do not set `RUSTFLAGS` | Overrides [`.cargo/config.toml`](../.cargo/config.toml) Windows rustflags. |

Product development notes (keychain prompts, frame measurements, ETW): [src/development.md](src/development.md).
