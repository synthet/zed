---
type: Report
title: Windows debug build 2026-08-15
description: Point-in-time notes from adding resumable Windows scripts and completing a local debug zed.exe.
resource: reports/windows-build-2026-08-15.md
tags: [docs, reports, windows, build]
timestamp: 2026-08-15T17:00:00Z
okf_version: 0.1
---

# Windows debug build — 2026-08-15

Parent: [reports/INDEX.md](INDEX.md) · Guide: [windows-dev.md](../guides/windows-dev.md)

Living how-to stays in the guide. This page is what happened in this checkout on 2026-08-15.

## Scripts landed

Commit [`1c465e3348`](https://github.com/synthet/zed/commit/1c465e3348) on [synthet/zed](https://github.com/synthet/zed) `main`: `script/windows.ps1`, `script/build-windows.ps1`, `script/lib/windows-env.ps1`, and a short section in [src/development/windows.md](../src/development/windows.md).

`vswhere` found **VS 2022 Build Tools** at `C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools`. CMake was `C:\Program Files\CMake\bin\cmake.exe`. Windows SDK **10.0.26100.0** (minimum in docs is 10.0.20348.0). Git `core.longpaths` was enabled. `LongPathsEnabled` in HKLM was **not** set (needs an elevated shell and a reboot).

## Spectre check vs stub

`script/windows.ps1 -Check` exited 1:

`Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre`

Cargo still built because `[patch.crates-io] msvc_spectre_libs` points at [`tooling/msvc_spectre_libs_stub`](../../tooling/msvc_spectre_libs_stub) ([fork-deltas.md](../architecture/fork-deltas.md)). The build wrapper’s `check_deps` step would have stopped; the successful compile used Dev Shell + `cargo build --package zed` and skipped that check.

## Resume in practice

1. First `cargo build --package zed` compiled into workspace crates, then died with **exit `-1` / `0xFFFFFFFF`** and no rustc diagnostic (~15 minutes). Incremental cache remained.
2. A second attempt blocked on **package cache** (Warp `cargo build -p warp --bin warp-oss` sharing `CARGO_HOME`) and **build directory** (rust-analyzer `cargo check -p zed`).
3. After locks cleared, incremental compile finished: `Finished dev profile … in 10m 02s`, `CARGO_EXIT=0`.
4. Artifact: `D:\Projects\zed\target\debug\zed.exe` (~513 MB), 2026-08-15 11:32 local.

Linker `LNK4217` (wasmtime / tree-sitter) and mojibake “creating library” messages from a non-Latin console locale did not fail the link.
