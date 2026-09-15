# Icons

Visual inventory of icons in this checkout. **Shipped Zed app icons** under
`crates/zed/resources/` are rendered from the vector masters in
`assets/branding/jetbrains-darcula-concepts/` — a flat `#101014` plate with a
silver mark (regenerate with
`uv run --with pillow python script/apply_branding_icons.py --zed-only`).
Validate all Windows icon sizes with
`uv run --with pillow python script/apply_branding_icons.py --check`.
Generation also requires ImageMagick 7's `magick` executable: Windows ICO entries
below 256 px are BMP32, while the 256 px entry is embedded PNG.

## Synth app icons (applied)

Matching Synth icons for Zed and Warp. Wired into Zed
(`crates/zed/resources/`) and Warp (`app/channels/oss`, `warp-oss`, `local`).
Vector masters and the design notes: `assets/branding/jetbrains-darcula-concepts/`.
The two PNGs below are generated previews, not sources.

<table>
<tr>
<td align="center"><img src="branding/synth-zed-app-icon.png" width="160"><br><b>Synth Zed</b></td>
<td align="center"><img src="branding/synth-warp-app-icon.png" width="160"><br><b>Synth Warp</b></td>
</tr>
</table>

## App icons

OS / installer / About-window art. All generated — edit the SVG masters, not these files. Channels
share one plate and one mark; only the glyph tint differs (preview `#6897BB`, nightly `#9876AA`,
dev `#CC7832`).

| Channel | 512 (`app-icon*.png`) | 1024 (`@2x`) | Windows ICO |
| --- | --- | --- | --- |
| Stable<br>`app-icon.png` | <img src="../crates/zed/resources/app-icon.png" alt="Stable" width="128"> | <img src="../crates/zed/resources/app-icon@2x.png" alt="Stable @2x" width="128"> | `windows/app-icon.ico` |
| Preview<br>`app-icon-preview.png` | <img src="../crates/zed/resources/app-icon-preview.png" alt="Preview" width="128"> | <img src="../crates/zed/resources/app-icon-preview@2x.png" alt="Preview @2x" width="128"> | `windows/app-icon-preview.ico` |
| Nightly<br>`app-icon-nightly.png` | <img src="../crates/zed/resources/app-icon-nightly.png" alt="Nightly" width="128"> | <img src="../crates/zed/resources/app-icon-nightly@2x.png" alt="Nightly @2x" width="128"> | `windows/app-icon-nightly.ico` |
| Dev<br>`app-icon-dev.png` | <img src="../crates/zed/resources/app-icon-dev.png" alt="Dev" width="128"> | <img src="../crates/zed/resources/app-icon-dev@2x.png" alt="Dev @2x" width="128"> | `windows/app-icon-dev.ico` |

Paths are under `crates/zed/resources/`. Wired from `crates/zed/Cargo.toml` (`package.metadata.bundle-*`), `crates/windows_resources`, `crates/zed/src/zed.rs` (About), and `script/bundle-*`.

## Product marks

| File | Preview |
| --- | --- |
| `images/business_stamp.svg` | <span style="display:inline-block;background:#fff;padding:8px;border-radius:4px"><img src="images/business_stamp.svg" alt="business_stamp" width="64"></span> |
| `images/grid.svg` | <span style="display:inline-block;background:#fff;padding:8px;border-radius:4px"><img src="images/grid.svg" alt="grid" width="64"></span> |
| `images/pro_trial_stamp.svg` | <span style="display:inline-block;background:#fff;padding:8px;border-radius:4px"><img src="images/pro_trial_stamp.svg" alt="pro_trial_stamp" width="64"></span> |
| `images/pro_user_stamp.svg` | <span style="display:inline-block;background:#fff;padding:8px;border-radius:4px"><img src="images/pro_user_stamp.svg" alt="pro_user_stamp" width="64"></span> |
| `images/student_stamp.svg` | <span style="display:inline-block;background:#fff;padding:8px;border-radius:4px"><img src="images/student_stamp.svg" alt="student_stamp" width="64"></span> |
| `images/vip_stamp.svg` | <span style="display:inline-block;background:#fff;padding:8px;border-radius:4px"><img src="images/vip_stamp.svg" alt="vip_stamp" width="64"></span> |
| `images/zed_logo.svg` | <span style="display:inline-block;background:#fff;padding:8px;border-radius:4px"><img src="images/zed_logo.svg" alt="zed_logo" width="64"></span> |
| `images/zed_x_copilot.svg` | <span style="display:inline-block;background:#fff;padding:8px;border-radius:4px"><img src="images/zed_x_copilot.svg" alt="zed_x_copilot" width="64"></span> |

`images/zed_logo.svg` is the Zed logomark from https://zed.dev/brand (96×96). It is both the
in-product mark and the glyph the OS app icons are built from — the branding masters place this
exact path on the Synth plate rather than redrawing it.

## UI icons

SVGs in `assets/icons/` (16×16, black stroke). They may disappear on a dark markdown theme; previews sit on white.

Guidelines: `crates/icons/README.md`. Enum: `crates/icons/src/icons.rs`.

### UI icons (root)

| Preview | Name |
| --- | --- |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/acp_registry.svg" alt="acp_registry" width="24"></span> | `acp_registry.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_anthropic.svg" alt="ai_anthropic" width="24"></span> | `ai_anthropic.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_anthropic_compat.svg" alt="ai_anthropic_compat" width="24"></span> | `ai_anthropic_compat.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_bedrock.svg" alt="ai_bedrock" width="24"></span> | `ai_bedrock.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_claude.svg" alt="ai_claude" width="24"></span> | `ai_claude.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_deep_seek.svg" alt="ai_deep_seek" width="24"></span> | `ai_deep_seek.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_edit.svg" alt="ai_edit" width="24"></span> | `ai_edit.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_gemini.svg" alt="ai_gemini" width="24"></span> | `ai_gemini.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_google.svg" alt="ai_google" width="24"></span> | `ai_google.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_llama_cpp.svg" alt="ai_llama_cpp" width="24"></span> | `ai_llama_cpp.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_lm_studio.svg" alt="ai_lm_studio" width="24"></span> | `ai_lm_studio.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_mistral.svg" alt="ai_mistral" width="24"></span> | `ai_mistral.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_ollama.svg" alt="ai_ollama" width="24"></span> | `ai_ollama.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_open_ai.svg" alt="ai_open_ai" width="24"></span> | `ai_open_ai.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_open_ai_compat.svg" alt="ai_open_ai_compat" width="24"></span> | `ai_open_ai_compat.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_open_ai_gpt_sub.svg" alt="ai_open_ai_gpt_sub" width="24"></span> | `ai_open_ai_gpt_sub.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_open_code.svg" alt="ai_open_code" width="24"></span> | `ai_open_code.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_open_router.svg" alt="ai_open_router" width="24"></span> | `ai_open_router.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_vercel.svg" alt="ai_vercel" width="24"></span> | `ai_vercel.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_x_ai.svg" alt="ai_x_ai" width="24"></span> | `ai_x_ai.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ai_zed.svg" alt="ai_zed" width="24"></span> | `ai_zed.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/archive.svg" alt="archive" width="24"></span> | `archive.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/arrow_circle.svg" alt="arrow_circle" width="24"></span> | `arrow_circle.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/arrow_down.svg" alt="arrow_down" width="24"></span> | `arrow_down.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/arrow_down10.svg" alt="arrow_down10" width="24"></span> | `arrow_down10.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/arrow_down_right.svg" alt="arrow_down_right" width="24"></span> | `arrow_down_right.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/arrow_left.svg" alt="arrow_left" width="24"></span> | `arrow_left.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/arrow_right.svg" alt="arrow_right" width="24"></span> | `arrow_right.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/arrow_right_left.svg" alt="arrow_right_left" width="24"></span> | `arrow_right_left.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/arrow_up.svg" alt="arrow_up" width="24"></span> | `arrow_up.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/arrow_up_right.svg" alt="arrow_up_right" width="24"></span> | `arrow_up_right.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/at_sign.svg" alt="at_sign" width="24"></span> | `at_sign.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/attach.svg" alt="attach" width="24"></span> | `attach.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/audio_off.svg" alt="audio_off" width="24"></span> | `audio_off.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/audio_on.svg" alt="audio_on" width="24"></span> | `audio_on.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/backspace.svg" alt="backspace" width="24"></span> | `backspace.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/bell.svg" alt="bell" width="24"></span> | `bell.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/bell_dot.svg" alt="bell_dot" width="24"></span> | `bell_dot.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/bell_off.svg" alt="bell_off" width="24"></span> | `bell_off.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/bell_ring.svg" alt="bell_ring" width="24"></span> | `bell_ring.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/binary.svg" alt="binary" width="24"></span> | `binary.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/bitbucket.svg" alt="bitbucket" width="24"></span> | `bitbucket.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/blocks.svg" alt="blocks" width="24"></span> | `blocks.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/bolt_filled.svg" alt="bolt_filled" width="24"></span> | `bolt_filled.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/bolt_outlined.svg" alt="bolt_outlined" width="24"></span> | `bolt_outlined.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/book.svg" alt="book" width="24"></span> | `book.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/book_copy.svg" alt="book_copy" width="24"></span> | `book_copy.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/bookmark.svg" alt="bookmark" width="24"></span> | `bookmark.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/box.svg" alt="box" width="24"></span> | `box.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/box_open.svg" alt="box_open" width="24"></span> | `box_open.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/case_sensitive.svg" alt="case_sensitive" width="24"></span> | `case_sensitive.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/chat.svg" alt="chat" width="24"></span> | `chat.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/check.svg" alt="check" width="24"></span> | `check.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/check_double.svg" alt="check_double" width="24"></span> | `check_double.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/chevron_down.svg" alt="chevron_down" width="24"></span> | `chevron_down.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/chevron_down_up.svg" alt="chevron_down_up" width="24"></span> | `chevron_down_up.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/chevron_left.svg" alt="chevron_left" width="24"></span> | `chevron_left.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/chevron_right.svg" alt="chevron_right" width="24"></span> | `chevron_right.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/chevron_up.svg" alt="chevron_up" width="24"></span> | `chevron_up.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/chevron_up_down.svg" alt="chevron_up_down" width="24"></span> | `chevron_up_down.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/circle.svg" alt="circle" width="24"></span> | `circle.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/circle_help.svg" alt="circle_help" width="24"></span> | `circle_help.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/clock.svg" alt="clock" width="24"></span> | `clock.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/close.svg" alt="close" width="24"></span> | `close.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/cloud_download.svg" alt="cloud_download" width="24"></span> | `cloud_download.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/code.svg" alt="code" width="24"></span> | `code.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/codeberg.svg" alt="codeberg" width="24"></span> | `codeberg.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/command.svg" alt="command" width="24"></span> | `command.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/compact.svg" alt="compact" width="24"></span> | `compact.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/control.svg" alt="control" width="24"></span> | `control.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/copilot.svg" alt="copilot" width="24"></span> | `copilot.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/copilot_disabled.svg" alt="copilot_disabled" width="24"></span> | `copilot_disabled.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/copilot_error.svg" alt="copilot_error" width="24"></span> | `copilot_error.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/copilot_init.svg" alt="copilot_init" width="24"></span> | `copilot_init.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/copy.svg" alt="copy" width="24"></span> | `copy.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/countdown_timer.svg" alt="countdown_timer" width="24"></span> | `countdown_timer.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/crosshair.svg" alt="crosshair" width="24"></span> | `crosshair.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/cursor_i_beam.svg" alt="cursor_i_beam" width="24"></span> | `cursor_i_beam.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/dash.svg" alt="dash" width="24"></span> | `dash.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/database_zap.svg" alt="database_zap" width="24"></span> | `database_zap.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/debug.svg" alt="debug" width="24"></span> | `debug.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/debug_breakpoint.svg" alt="debug_breakpoint" width="24"></span> | `debug_breakpoint.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/debug_continue.svg" alt="debug_continue" width="24"></span> | `debug_continue.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/debug_detach.svg" alt="debug_detach" width="24"></span> | `debug_detach.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/debug_disabled_breakpoint.svg" alt="debug_disabled_breakpoint" width="24"></span> | `debug_disabled_breakpoint.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/debug_disabled_log_breakpoint.svg" alt="debug_disabled_log_breakpoint" width="24"></span> | `debug_disabled_log_breakpoint.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/debug_ignore_breakpoints.svg" alt="debug_ignore_breakpoints" width="24"></span> | `debug_ignore_breakpoints.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/debug_log_breakpoint.svg" alt="debug_log_breakpoint" width="24"></span> | `debug_log_breakpoint.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/debug_pause.svg" alt="debug_pause" width="24"></span> | `debug_pause.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/debug_step_into.svg" alt="debug_step_into" width="24"></span> | `debug_step_into.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/debug_step_out.svg" alt="debug_step_out" width="24"></span> | `debug_step_out.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/debug_step_over.svg" alt="debug_step_over" width="24"></span> | `debug_step_over.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/diff.svg" alt="diff" width="24"></span> | `diff.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/diff_split.svg" alt="diff_split" width="24"></span> | `diff_split.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/diff_split_auto.svg" alt="diff_split_auto" width="24"></span> | `diff_split_auto.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/diff_unified.svg" alt="diff_unified" width="24"></span> | `diff_unified.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/disconnected.svg" alt="disconnected" width="24"></span> | `disconnected.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/download.svg" alt="download" width="24"></span> | `download.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/editor_atom.svg" alt="editor_atom" width="24"></span> | `editor_atom.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/editor_cursor.svg" alt="editor_cursor" width="24"></span> | `editor_cursor.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/editor_emacs.svg" alt="editor_emacs" width="24"></span> | `editor_emacs.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/editor_jet_brains.svg" alt="editor_jet_brains" width="24"></span> | `editor_jet_brains.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/editor_sublime.svg" alt="editor_sublime" width="24"></span> | `editor_sublime.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/editor_vs_code.svg" alt="editor_vs_code" width="24"></span> | `editor_vs_code.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/ellipsis.svg" alt="ellipsis" width="24"></span> | `ellipsis.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/envelope.svg" alt="envelope" width="24"></span> | `envelope.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/eraser.svg" alt="eraser" width="24"></span> | `eraser.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/escape.svg" alt="escape" width="24"></span> | `escape.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/exit.svg" alt="exit" width="24"></span> | `exit.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/expand_down.svg" alt="expand_down" width="24"></span> | `expand_down.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/expand_up.svg" alt="expand_up" width="24"></span> | `expand_up.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/expand_vertical.svg" alt="expand_vertical" width="24"></span> | `expand_vertical.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/eye.svg" alt="eye" width="24"></span> | `eye.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/eye_off.svg" alt="eye_off" width="24"></span> | `eye_off.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/fast_forward.svg" alt="fast_forward" width="24"></span> | `fast_forward.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/fast_forward_off.svg" alt="fast_forward_off" width="24"></span> | `fast_forward_off.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file.svg" alt="file" width="24"></span> | `file.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_code.svg" alt="file_code" width="24"></span> | `file_code.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_diff.svg" alt="file_diff" width="24"></span> | `file_diff.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_doc.svg" alt="file_doc" width="24"></span> | `file_doc.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_generic.svg" alt="file_generic" width="24"></span> | `file_generic.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_git.svg" alt="file_git" width="24"></span> | `file_git.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_ignored.svg" alt="file_ignored" width="24"></span> | `file_ignored.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_lock.svg" alt="file_lock" width="24"></span> | `file_lock.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_markdown.svg" alt="file_markdown" width="24"></span> | `file_markdown.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_multiple.svg" alt="file_multiple" width="24"></span> | `file_multiple.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_rust.svg" alt="file_rust" width="24"></span> | `file_rust.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_text_filled.svg" alt="file_text_filled" width="24"></span> | `file_text_filled.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_text_outlined.svg" alt="file_text_outlined" width="24"></span> | `file_text_outlined.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_toml.svg" alt="file_toml" width="24"></span> | `file_toml.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_tree.svg" alt="file_tree" width="24"></span> | `file_tree.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/filter.svg" alt="filter" width="24"></span> | `filter.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/flame.svg" alt="flame" width="24"></span> | `flame.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/fold_vertical.svg" alt="fold_vertical" width="24"></span> | `fold_vertical.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/folder.svg" alt="folder" width="24"></span> | `folder.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/folder_add.svg" alt="folder_add" width="24"></span> | `folder_add.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/folder_include.svg" alt="folder_include" width="24"></span> | `folder_include.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/folder_open.svg" alt="folder_open" width="24"></span> | `folder_open.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/folder_search.svg" alt="folder_search" width="24"></span> | `folder_search.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/folder_share.svg" alt="folder_share" width="24"></span> | `folder_share.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/folder_shared.svg" alt="folder_shared" width="24"></span> | `folder_shared.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/font.svg" alt="font" width="24"></span> | `font.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/font_size.svg" alt="font_size" width="24"></span> | `font_size.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/font_weight.svg" alt="font_weight" width="24"></span> | `font_weight.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/forgejo.svg" alt="forgejo" width="24"></span> | `forgejo.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/forward_arrow.svg" alt="forward_arrow" width="24"></span> | `forward_arrow.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/forward_arrow_up.svg" alt="forward_arrow_up" width="24"></span> | `forward_arrow_up.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/generic_close.svg" alt="generic_close" width="24"></span> | `generic_close.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/generic_maximize.svg" alt="generic_maximize" width="24"></span> | `generic_maximize.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/generic_minimize.svg" alt="generic_minimize" width="24"></span> | `generic_minimize.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/generic_restore.svg" alt="generic_restore" width="24"></span> | `generic_restore.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/gerrit.svg" alt="gerrit" width="24"></span> | `gerrit.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/git_branch.svg" alt="git_branch" width="24"></span> | `git_branch.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/git_branch_plus.svg" alt="git_branch_plus" width="24"></span> | `git_branch_plus.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/git_commit.svg" alt="git_commit" width="24"></span> | `git_commit.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/git_graph.svg" alt="git_graph" width="24"></span> | `git_graph.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/git_merge_conflict.svg" alt="git_merge_conflict" width="24"></span> | `git_merge_conflict.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/git_worktree.svg" alt="git_worktree" width="24"></span> | `git_worktree.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/gitea.svg" alt="gitea" width="24"></span> | `gitea.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/github.svg" alt="github" width="24"></span> | `github.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/gitlab.svg" alt="gitlab" width="24"></span> | `gitlab.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/hash.svg" alt="hash" width="24"></span> | `hash.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/history_rerun.svg" alt="history_rerun" width="24"></span> | `history_rerun.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/image.svg" alt="image" width="24"></span> | `image.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/inception.svg" alt="inception" width="24"></span> | `inception.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/indicator.svg" alt="indicator" width="24"></span> | `indicator.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/info.svg" alt="info" width="24"></span> | `info.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/json.svg" alt="json" width="24"></span> | `json.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/keyboard.svg" alt="keyboard" width="24"></span> | `keyboard.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/line_height.svg" alt="line_height" width="24"></span> | `line_height.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/link.svg" alt="link" width="24"></span> | `link.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/linux.svg" alt="linux" width="24"></span> | `linux.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/list_collapse.svg" alt="list_collapse" width="24"></span> | `list_collapse.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/list_todo.svg" alt="list_todo" width="24"></span> | `list_todo.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/list_tree.svg" alt="list_tree" width="24"></span> | `list_tree.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/list_x.svg" alt="list_x" width="24"></span> | `list_x.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/load_circle.svg" alt="load_circle" width="24"></span> | `load_circle.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/location_edit.svg" alt="location_edit" width="24"></span> | `location_edit.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/lock.svg" alt="lock" width="24"></span> | `lock.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/lock_off.svg" alt="lock_off" width="24"></span> | `lock_off.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/magnifying_glass.svg" alt="magnifying_glass" width="24"></span> | `magnifying_glass.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/maximize.svg" alt="maximize" width="24"></span> | `maximize.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/maximize_alt.svg" alt="maximize_alt" width="24"></span> | `maximize_alt.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/menu.svg" alt="menu" width="24"></span> | `menu.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/mic.svg" alt="mic" width="24"></span> | `mic.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/mic_mute.svg" alt="mic_mute" width="24"></span> | `mic_mute.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/minimize.svg" alt="minimize" width="24"></span> | `minimize.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/notepad.svg" alt="notepad" width="24"></span> | `notepad.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/on_call.svg" alt="on_call" width="24"></span> | `on_call.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/option.svg" alt="option" width="24"></span> | `option.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/page_down.svg" alt="page_down" width="24"></span> | `page_down.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/page_up.svg" alt="page_up" width="24"></span> | `page_up.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/paperclip.svg" alt="paperclip" width="24"></span> | `paperclip.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/pencil.svg" alt="pencil" width="24"></span> | `pencil.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/pencil_unavailable.svg" alt="pencil_unavailable" width="24"></span> | `pencil_unavailable.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/person.svg" alt="person" width="24"></span> | `person.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/pin.svg" alt="pin" width="24"></span> | `pin.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/play_filled.svg" alt="play_filled" width="24"></span> | `play_filled.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/play_outlined.svg" alt="play_outlined" width="24"></span> | `play_outlined.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/plus.svg" alt="plus" width="24"></span> | `plus.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/power.svg" alt="power" width="24"></span> | `power.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/public.svg" alt="public" width="24"></span> | `public.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/pull_request.svg" alt="pull_request" width="24"></span> | `pull_request.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/queue_message.svg" alt="queue_message" width="24"></span> | `queue_message.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/quote.svg" alt="quote" width="24"></span> | `quote.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/reader.svg" alt="reader" width="24"></span> | `reader.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/refresh_title.svg" alt="refresh_title" width="24"></span> | `refresh_title.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/regex.svg" alt="regex" width="24"></span> | `regex.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/repl_neutral.svg" alt="repl_neutral" width="24"></span> | `repl_neutral.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/replace.svg" alt="replace" width="24"></span> | `replace.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/replace_all.svg" alt="replace_all" width="24"></span> | `replace_all.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/replace_next.svg" alt="replace_next" width="24"></span> | `replace_next.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/reply_arrow_right.svg" alt="reply_arrow_right" width="24"></span> | `reply_arrow_right.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/rerun.svg" alt="rerun" width="24"></span> | `rerun.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/return.svg" alt="return" width="24"></span> | `return.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/rotate_ccw.svg" alt="rotate_ccw" width="24"></span> | `rotate_ccw.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/rotate_cw.svg" alt="rotate_cw" width="24"></span> | `rotate_cw.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/scissors.svg" alt="scissors" width="24"></span> | `scissors.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/screen.svg" alt="screen" width="24"></span> | `screen.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/select_all.svg" alt="select_all" width="24"></span> | `select_all.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/send.svg" alt="send" width="24"></span> | `send.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/server.svg" alt="server" width="24"></span> | `server.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/settings.svg" alt="settings" width="24"></span> | `settings.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/share.svg" alt="share" width="24"></span> | `share.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/shift.svg" alt="shift" width="24"></span> | `shift.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/signal_high.svg" alt="signal_high" width="24"></span> | `signal_high.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/signal_low.svg" alt="signal_low" width="24"></span> | `signal_low.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/signal_medium.svg" alt="signal_medium" width="24"></span> | `signal_medium.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/slash.svg" alt="slash" width="24"></span> | `slash.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/sourcehut.svg" alt="sourcehut" width="24"></span> | `sourcehut.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/space.svg" alt="space" width="24"></span> | `space.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/sparkle.svg" alt="sparkle" width="24"></span> | `sparkle.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/split.svg" alt="split" width="24"></span> | `split.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/split_alt.svg" alt="split_alt" width="24"></span> | `split_alt.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/square_dot.svg" alt="square_dot" width="24"></span> | `square_dot.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/square_minus.svg" alt="square_minus" width="24"></span> | `square_minus.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/square_plus.svg" alt="square_plus" width="24"></span> | `square_plus.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/star.svg" alt="star" width="24"></span> | `star.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/star_filled.svg" alt="star_filled" width="24"></span> | `star_filled.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/stop.svg" alt="stop" width="24"></span> | `stop.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/tab.svg" alt="tab" width="24"></span> | `tab.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/table.svg" alt="table" width="24"></span> | `table.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/terminal.svg" alt="terminal" width="24"></span> | `terminal.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/terminal_alt.svg" alt="terminal_alt" width="24"></span> | `terminal_alt.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/text_snippet.svg" alt="text_snippet" width="24"></span> | `text_snippet.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/text_unwrap.svg" alt="text_unwrap" width="24"></span> | `text_unwrap.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/text_wrap.svg" alt="text_wrap" width="24"></span> | `text_wrap.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/thinking_mode.svg" alt="thinking_mode" width="24"></span> | `thinking_mode.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/thinking_mode_off.svg" alt="thinking_mode_off" width="24"></span> | `thinking_mode_off.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/this_window.svg" alt="this_window" width="24"></span> | `this_window.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/thread.svg" alt="thread" width="24"></span> | `thread.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/thread_from_summary.svg" alt="thread_from_summary" width="24"></span> | `thread_from_summary.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/threads_sidebar_left_closed.svg" alt="threads_sidebar_left_closed" width="24"></span> | `threads_sidebar_left_closed.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/threads_sidebar_left_open.svg" alt="threads_sidebar_left_open" width="24"></span> | `threads_sidebar_left_open.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/threads_sidebar_right_closed.svg" alt="threads_sidebar_right_closed" width="24"></span> | `threads_sidebar_right_closed.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/threads_sidebar_right_open.svg" alt="threads_sidebar_right_open" width="24"></span> | `threads_sidebar_right_open.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/thumbs_down.svg" alt="thumbs_down" width="24"></span> | `thumbs_down.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/thumbs_up.svg" alt="thumbs_up" width="24"></span> | `thumbs_up.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/todo_complete.svg" alt="todo_complete" width="24"></span> | `todo_complete.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/todo_pending.svg" alt="todo_pending" width="24"></span> | `todo_pending.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/todo_progress.svg" alt="todo_progress" width="24"></span> | `todo_progress.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/tool_copy.svg" alt="tool_copy" width="24"></span> | `tool_copy.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/tool_delete_file.svg" alt="tool_delete_file" width="24"></span> | `tool_delete_file.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/tool_diagnostics.svg" alt="tool_diagnostics" width="24"></span> | `tool_diagnostics.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/tool_hammer.svg" alt="tool_hammer" width="24"></span> | `tool_hammer.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/tool_notification.svg" alt="tool_notification" width="24"></span> | `tool_notification.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/tool_pencil.svg" alt="tool_pencil" width="24"></span> | `tool_pencil.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/tool_search.svg" alt="tool_search" width="24"></span> | `tool_search.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/tool_terminal.svg" alt="tool_terminal" width="24"></span> | `tool_terminal.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/tool_think.svg" alt="tool_think" width="24"></span> | `tool_think.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/tool_web.svg" alt="tool_web" width="24"></span> | `tool_web.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/trash.svg" alt="trash" width="24"></span> | `trash.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/triangle.svg" alt="triangle" width="24"></span> | `triangle.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/triangle_right.svg" alt="triangle_right" width="24"></span> | `triangle_right.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/undo.svg" alt="undo" width="24"></span> | `undo.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/unpin.svg" alt="unpin" width="24"></span> | `unpin.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/user_arrow_up.svg" alt="user_arrow_up" width="24"></span> | `user_arrow_up.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/user_check.svg" alt="user_check" width="24"></span> | `user_check.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/user_group.svg" alt="user_group" width="24"></span> | `user_group.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/user_round_pen.svg" alt="user_round_pen" width="24"></span> | `user_round_pen.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/warning.svg" alt="warning" width="24"></span> | `warning.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/whole_word.svg" alt="whole_word" width="24"></span> | `whole_word.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/x_circle.svg" alt="x_circle" width="24"></span> | `x_circle.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/x_circle_filled.svg" alt="x_circle_filled" width="24"></span> | `x_circle_filled.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/zed_agent.svg" alt="zed_agent" width="24"></span> | `zed_agent.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/zed_agent_two.svg" alt="zed_agent_two" width="24"></span> | `zed_agent_two.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/zed_assistant.svg" alt="zed_assistant" width="24"></span> | `zed_assistant.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/zed_predict.svg" alt="zed_predict" width="24"></span> | `zed_predict.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/zed_predict_disabled.svg" alt="zed_predict_disabled" width="24"></span> | `zed_predict_disabled.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/zed_predict_down.svg" alt="zed_predict_down" width="24"></span> | `zed_predict_down.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/zed_predict_error.svg" alt="zed_predict_error" width="24"></span> | `zed_predict_error.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/zed_predict_up.svg" alt="zed_predict_up" width="24"></span> | `zed_predict_up.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/zed_src_custom.svg" alt="zed_src_custom" width="24"></span> | `zed_src_custom.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/zed_src_extension.svg" alt="zed_src_extension" width="24"></span> | `zed_src_extension.svg` |

### UI icons / `file_icons`

| Preview | Name |
| --- | --- |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/ai.svg" alt="ai" width="24"></span> | `file_icons/ai.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/archive.svg" alt="archive" width="24"></span> | `file_icons/archive.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/astro.svg" alt="astro" width="24"></span> | `file_icons/astro.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/audio.svg" alt="audio" width="24"></span> | `file_icons/audio.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/ballerina.svg" alt="ballerina" width="24"></span> | `file_icons/ballerina.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/book.svg" alt="book" width="24"></span> | `file_icons/book.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/bun.svg" alt="bun" width="24"></span> | `file_icons/bun.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/c.svg" alt="c" width="24"></span> | `file_icons/c.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/cairo.svg" alt="cairo" width="24"></span> | `file_icons/cairo.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/camera.svg" alt="camera" width="24"></span> | `file_icons/camera.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/chevron_down.svg" alt="chevron_down" width="24"></span> | `file_icons/chevron_down.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/chevron_left.svg" alt="chevron_left" width="24"></span> | `file_icons/chevron_left.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/chevron_right.svg" alt="chevron_right" width="24"></span> | `file_icons/chevron_right.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/chevron_up.svg" alt="chevron_up" width="24"></span> | `file_icons/chevron_up.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/code.svg" alt="code" width="24"></span> | `file_icons/code.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/coffeescript.svg" alt="coffeescript" width="24"></span> | `file_icons/coffeescript.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/conversations.svg" alt="conversations" width="24"></span> | `file_icons/conversations.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/cpp.svg" alt="cpp" width="24"></span> | `file_icons/cpp.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/css.svg" alt="css" width="24"></span> | `file_icons/css.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/dart.svg" alt="dart" width="24"></span> | `file_icons/dart.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/database.svg" alt="database" width="24"></span> | `file_icons/database.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/diff.svg" alt="diff" width="24"></span> | `file_icons/diff.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/docker.svg" alt="docker" width="24"></span> | `file_icons/docker.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/editorconfig.svg" alt="editorconfig" width="24"></span> | `file_icons/editorconfig.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/elixir.svg" alt="elixir" width="24"></span> | `file_icons/elixir.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/elm.svg" alt="elm" width="24"></span> | `file_icons/elm.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/erlang.svg" alt="erlang" width="24"></span> | `file_icons/erlang.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/eslint.svg" alt="eslint" width="24"></span> | `file_icons/eslint.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/file.svg" alt="file" width="24"></span> | `file_icons/file.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/folder.svg" alt="folder" width="24"></span> | `file_icons/folder.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/folder_open.svg" alt="folder_open" width="24"></span> | `file_icons/folder_open.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/font.svg" alt="font" width="24"></span> | `file_icons/font.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/fsharp.svg" alt="fsharp" width="24"></span> | `file_icons/fsharp.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/git.svg" alt="git" width="24"></span> | `file_icons/git.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/gitlab.svg" alt="gitlab" width="24"></span> | `file_icons/gitlab.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/gleam.svg" alt="gleam" width="24"></span> | `file_icons/gleam.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/go.svg" alt="go" width="24"></span> | `file_icons/go.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/graphql.svg" alt="graphql" width="24"></span> | `file_icons/graphql.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/hash.svg" alt="hash" width="24"></span> | `file_icons/hash.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/haskell.svg" alt="haskell" width="24"></span> | `file_icons/haskell.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/hcl.svg" alt="hcl" width="24"></span> | `file_icons/hcl.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/helm.svg" alt="helm" width="24"></span> | `file_icons/helm.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/heroku.svg" alt="heroku" width="24"></span> | `file_icons/heroku.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/html.svg" alt="html" width="24"></span> | `file_icons/html.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/image.svg" alt="image" width="24"></span> | `file_icons/image.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/info.svg" alt="info" width="24"></span> | `file_icons/info.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/java.svg" alt="java" width="24"></span> | `file_icons/java.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/javascript.svg" alt="javascript" width="24"></span> | `file_icons/javascript.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/julia.svg" alt="julia" width="24"></span> | `file_icons/julia.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/jupyter.svg" alt="jupyter" width="24"></span> | `file_icons/jupyter.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/kdl.svg" alt="kdl" width="24"></span> | `file_icons/kdl.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/kotlin.svg" alt="kotlin" width="24"></span> | `file_icons/kotlin.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/lock.svg" alt="lock" width="24"></span> | `file_icons/lock.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/lua.svg" alt="lua" width="24"></span> | `file_icons/lua.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/luau.svg" alt="luau" width="24"></span> | `file_icons/luau.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/magnifying_glass.svg" alt="magnifying_glass" width="24"></span> | `file_icons/magnifying_glass.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/metal.svg" alt="metal" width="24"></span> | `file_icons/metal.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/nim.svg" alt="nim" width="24"></span> | `file_icons/nim.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/nix.svg" alt="nix" width="24"></span> | `file_icons/nix.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/notebook.svg" alt="notebook" width="24"></span> | `file_icons/notebook.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/ocaml.svg" alt="ocaml" width="24"></span> | `file_icons/ocaml.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/odin.svg" alt="odin" width="24"></span> | `file_icons/odin.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/package.svg" alt="package" width="24"></span> | `file_icons/package.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/phoenix.svg" alt="phoenix" width="24"></span> | `file_icons/phoenix.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/php.svg" alt="php" width="24"></span> | `file_icons/php.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/plus.svg" alt="plus" width="24"></span> | `file_icons/plus.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/prettier.svg" alt="prettier" width="24"></span> | `file_icons/prettier.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/prisma.svg" alt="prisma" width="24"></span> | `file_icons/prisma.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/project.svg" alt="project" width="24"></span> | `file_icons/project.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/puppet.svg" alt="puppet" width="24"></span> | `file_icons/puppet.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/python.svg" alt="python" width="24"></span> | `file_icons/python.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/r.svg" alt="r" width="24"></span> | `file_icons/r.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/react.svg" alt="react" width="24"></span> | `file_icons/react.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/replace.svg" alt="replace" width="24"></span> | `file_icons/replace.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/replace_all.svg" alt="replace_all" width="24"></span> | `file_icons/replace_all.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/replace_next.svg" alt="replace_next" width="24"></span> | `file_icons/replace_next.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/roc.svg" alt="roc" width="24"></span> | `file_icons/roc.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/ruby.svg" alt="ruby" width="24"></span> | `file_icons/ruby.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/rust.svg" alt="rust" width="24"></span> | `file_icons/rust.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/sass.svg" alt="sass" width="24"></span> | `file_icons/sass.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/scala.svg" alt="scala" width="24"></span> | `file_icons/scala.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/settings.svg" alt="settings" width="24"></span> | `file_icons/settings.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/surrealql.svg" alt="surrealql" width="24"></span> | `file_icons/surrealql.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/swift.svg" alt="swift" width="24"></span> | `file_icons/swift.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/tcl.svg" alt="tcl" width="24"></span> | `file_icons/tcl.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/terminal.svg" alt="terminal" width="24"></span> | `file_icons/terminal.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/terraform.svg" alt="terraform" width="24"></span> | `file_icons/terraform.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/toml.svg" alt="toml" width="24"></span> | `file_icons/toml.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/typescript.svg" alt="typescript" width="24"></span> | `file_icons/typescript.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/v.svg" alt="v" width="24"></span> | `file_icons/v.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/video.svg" alt="video" width="24"></span> | `file_icons/video.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/vue.svg" alt="vue" width="24"></span> | `file_icons/vue.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/vyper.svg" alt="vyper" width="24"></span> | `file_icons/vyper.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/wgsl.svg" alt="wgsl" width="24"></span> | `file_icons/wgsl.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/yaml.svg" alt="yaml" width="24"></span> | `file_icons/yaml.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/file_icons/zig.svg" alt="zig" width="24"></span> | `file_icons/zig.svg` |

### UI icons / `knockouts`

| Preview | Name |
| --- | --- |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/knockouts/dot_bg.svg" alt="dot_bg" width="24"></span> | `knockouts/dot_bg.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/knockouts/dot_fg.svg" alt="dot_fg" width="24"></span> | `knockouts/dot_fg.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/knockouts/triangle_bg.svg" alt="triangle_bg" width="24"></span> | `knockouts/triangle_bg.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/knockouts/triangle_fg.svg" alt="triangle_fg" width="24"></span> | `knockouts/triangle_fg.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/knockouts/x_bg.svg" alt="x_bg" width="24"></span> | `knockouts/x_bg.svg` |
| <span style="display:inline-block;background:#fff;padding:6px;border-radius:4px"><img src="icons/knockouts/x_fg.svg" alt="x_fg" width="24"></span> | `knockouts/x_fg.svg` |

_Total UI SVGs: 396_

