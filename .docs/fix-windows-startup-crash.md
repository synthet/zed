# Plan: fix the Windows startup crash

## Goal and evidence

Restore the installed stable Zed so it opens a workspace and parses files without crashing. Keep the repair limited to the Wasmtime linkage defect and a packaging guard that catches it.

The installed `C:\Users\dmnsy\AppData\Local\Programs\Zed\Zed.exe` is `1.17.0+stable.bf28d5c`. Four available dumps show `0xc0000005` at the loaded image base, with the same return address (`Zed.exe` RVA `0x1313d2af`). The preceding instruction calls through a pointer slot at RVA `0x155a5d68`; that slot holds the image base. Tree-sitter's `ts_wasm_store_new` calls `wasmtime_store_new` there. `script/check-unresolved-pointers.py` finds 48 such slots in the installed EXE. The existing `target/release/zed.exe` has zero, but it identifies itself as a **dev** build, so it cannot replace the stable installation.

## Work

1. **Review the pending fix without disturbing other changes.** Inspect the uncommitted `crates/language/src/wasmtime_c_api_keepalive.rs` and its module declaration in `crates/language/src/language.rs`. Confirm the retained Wasmtime C API symbols cover Tree-sitter's C references and that the module is included in the Windows build. Keep unrelated working-tree edits untouched.
2. **Make the packaging check fail closed.** Keep `script/check-unresolved-pointers.py` as the binary-level guard. In `script/bundle-windows.ps1`, check `$LASTEXITCODE` immediately after invoking Python and throw if it is nonzero; a nonzero native exit currently does not guarantee that PowerShell stops before copying a bad EXE. Run small Python and PowerShell checks for the guard: the installed EXE must fail, the existing dev EXE must pass, and a simulated checker failure must stop packaging before the copy step. Avoid broad Rust test suites.
3. **Produce one stable candidate when a build is permitted.** Set `ZED_RELEASE_CHANNEL=stable` and build only the `zed` package in release mode for `x86_64-pc-windows-msvc`. Do not use the existing dev EXE as the stable candidate. Run the pointer checker on the new EXE and verify its embedded product version says `stable` and identifies the intended source revision. If the checker still finds image-base slots, stop and inspect the emitted linkage before any deployment.
4. **Deploy only the verified EXE.** After Zed exits, record the installed EXE's version and hash, and save a rollback copy outside the application path. Replace `C:\Users\dmnsy\AppData\Local\Programs\Zed\Zed.exe` with the verified stable candidate. Check the installed copy's hash, version, and pointer slots again. The CLI and other installed binaries need replacement only if their compatibility actually requires it. This step writes outside the repo and should use the normal sandbox approval at execution time.
5. **Smoke-test and roll back if needed.** Launch the installed Zed, reopen the workspace that crashed, open and edit a file so Tree-sitter creates a parser, and use it for several minutes. Confirm no new Zed crash event or dump appears. If it crashes or opens as the wrong channel, restore the saved EXE and retain the new dump for analysis.

## Completion criteria

- A newly built **stable** EXE passes `script/check-unresolved-pointers.py` with zero image-base pointer slots.
- The packaging path stops on a failing checker and never copies the failing binary.
- The installed EXE has the same hash as the verified stable candidate.
- Opening the previously crashing workspace and using an editor does not produce a new access-violation dump.

The investigation and this plan require no rebuild. Step 3 is the one unavoidable Rust build for a repaired stable binary; defer it while the current limit on heavy Rust processes remains in effect. Until then, the installed EXE remains faulty.
