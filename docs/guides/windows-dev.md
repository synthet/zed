---
type: Guide
title: Windows Development
description: Windows source-build scripts, Spectre stub, resume, and cargo lock pitfalls.
resource: guides/windows-dev.md
tags: [docs, guides, windows, build]
timestamp: 2026-08-15T17:00:00Z
okf_version: 0.1
---

# Windows development

Parent: [guides/INDEX.md](INDEX.md) · Hub: [DEVELOPMENT.md](../DEVELOPMENT.md)

Canonical product page: [src/development/windows.md](../src/development/windows.md). Do not copy it here. Session snapshot: [windows-build-2026-08-15.md](../reports/windows-build-2026-08-15.md). Stuck: [TROUBLESHOOTING.md](../TROUBLESHOOTING.md).

## Scripts

Helpers live under `script/` (PowerShell). They locate MSVC with `vswhere` (`-products *`), so Visual Studio **Build Tools** works. You do not need a Developer PowerShell window. `script/bundle-windows.ps1` still hardcodes VS 2022 Community and is the installer bundler, not the local debug path.

| Script | Role |
|--------|------|
| [`script/windows.ps1`](../../script/windows.ps1) | Idempotent deps. `-Check` is read-only. `-InstallDeps` may winget-install CMake / Build Tools. rustup is installed even without `-InstallDeps`. |
| [`script/build-windows.ps1`](../../script/build-windows.ps1) | Enter VS Dev Shell, then check → toolchain → `cargo fetch` → `cargo build -p zed`. |
| [`script/lib/windows-env.ps1`](../../script/lib/windows-env.ps1) | Shared vswhere / Dev Shell / checkpoint helper. |

```powershell
script/windows.ps1
script/windows.ps1 -Check
script/windows.ps1 -InstallDeps

script/build-windows.ps1
script/build-windows.ps1 -Release
script/build-windows.ps1 -Resume
script/build-windows.ps1 -Run
script/build-windows.ps1 -Clean
```

Checkpoints: `target/.build-windows-state.json` (gitignored). Re-run after a crash: MSVC is re-initialized, finished **setup** steps are skipped, `cargo build` always runs so incremental compilation resumes. The script never `cargo clean` unless `-Clean`. Do not set `RUSTFLAGS` (it overrides [`.cargo/config.toml`](../../.cargo/config.toml) Windows rustflags).

## Spectre libs vs this fork

`windows.ps1 -Check` **fails** if `Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre` is missing. Official / release builds want the real VS component.

This fork patches `msvc_spectre_libs` to [`tooling/msvc_spectre_libs_stub`](../../tooling/msvc_spectre_libs_stub) so local `cargo build` / `cargo check` can proceed without that component. See [fork-deltas.md](../architecture/fork-deltas.md). If `-Check` is the only failure, enter the Dev Shell (or run `Enter-ZedVsDevShell` from the lib) and `cargo build --package zed` anyway.

Prefer installing Spectre libs for anything you would ship.

## Cargo locks

Two common waits, not compile errors:

- **Build directory** — rust-analyzer `cargo check -p zed` holds `target/` in this checkout. Wait, or pause the language server.
- **Package cache** — another Cargo using the same `CARGO_HOME` (observed: Warp `cargo build -p warp` in `D:/Projects/warp`). Wait. Do not kill the sibling build.

Incremental cache under `target/debug/incremental` is enough to resume after a killed `cargo` (exit `-1` with no rustc error is usually OOM or an interrupted process).

## Output

Debug binary: `target/debug/zed.exe`. Linker `LNK4217` and garbled “creating library” lines on a non-Latin Windows locale are warnings.

App ids: `SynthZed-Editor-*`. General cargo/clippy/nextest: [local-build.md](local-build.md).
