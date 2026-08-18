# Synthet bundled themes

This directory adds 24 Zed theme variants from the cross-app `synthet-theme` artifact library.
Together with the 11 Ayu, Gruvbox, and One variants already under `assets/themes`, that is 35
theme variants presenting 35 distinct names — no two variants share a name. The existing 11
Zed-sourced variants retain their established names and byte-identical bundled files.

**This file is the engineering record**: pinned upstream revisions, what was verified, and what was
adapted. The end-user legal notice lives in [`../LICENSES`](../LICENSES), which is concatenated into
the generated `assets/licenses.md` shipped behind `zed: open licenses`. If you add or remove a theme
here, update that file too — this one is never shown to users.

## Naming

The imported variants use **plain display names** — `Koi`, `Catppuccin Mocha`, `Tokyo Night` — with
no source prefix, matching the names their upstreams use.

`theme_settings::load_bundled_themes` inserts families into the registry keyed by name, so a
duplicate name would silently shadow whichever file loads first. The name set is asserted in
`crates/theme_settings/tests/synthet_default_themes.rs`, which keeps that from regressing.

## `popular-dark/` — 5 variants

Zed implementations of widely used dark palettes. Each was verified slot by slot against its real
upstream — `background`, `text`, and all 16 `terminal.ansi.*` values.

| Theme | Upstream verified against | Result | License |
|---|---|---|---|
| `nord.json` | [`nordtheme/visual-studio-code`](https://github.com/nordtheme/visual-studio-code) `develop/themes/nord-color-theme.json` | **exact** — 16/16 ANSI plus background and foreground | MIT |
| `catppuccin-mocha.json` | [`catppuccin/palette`](https://github.com/catppuccin/palette) `main/palette.json` | **exact** — all 12 mapped slots (`pink`→magenta, `teal`→cyan) | MIT |
| `github-dark-default.json` | [`primer/primitives`](https://github.com/primer/primitives) `dist/json/colors/dark.json` | **adaptation** — see below | MIT |
| `tokyo-night.json` | [`folke/tokyonight.nvim`](https://github.com/folke/tokyonight.nvim) `extras/wezterm/tokyonight_night.toml` | normal 8/8 **exact**; bright variants are original | Apache-2.0 |
| `jetbrains-darcula.json` | [`JetBrains/intellij-community`](https://github.com/JetBrains/intellij-community) `platform/platform-resources/src/DefaultColorSchemesManager.xml`, `Darcula` scheme | **adaptation** — see below | Apache-2.0 |

### Adaptations in this group

Neither GitHub nor JetBrains publishes a 16-colour ANSI set for these themes, so both are built by
mapping the upstream **syntax** palette onto Zed's terminal slots:

- `github-dark-default.json` uses GitHub's `prettylights.syntax` values — `keyword` to red,
  `entityTag` to green, `variable` to yellow, `constant` to blue, `entity` to magenta, `string` to
  cyan, `comment` to bright black — with `canvas.default` for background and `fg.default` for text.
  `bright_red` is upstream's `ansi.redBright`. `bright_cyan` (`#b6e3ff`) and `bright_magenta`
  (`#d8b9ff`) are not in the current primitives package and are original.
- `jetbrains-darcula.json` uses Darcula's scheme colours — keyword `#cc7832` to red, string
  `#6a8759` to green, function declaration `#ffc66d` to yellow, number `#6897bb` to blue, instance
  field `#9876aa` to magenta, doc comment `#629755` to cyan, default text `#a9b7c6` to white, and
  background `#2b2b2b`. All nine are present in the upstream `Darcula` scheme; the six bright
  variants are original lightenings.
- `tokyo-night.json` takes its eight normal colours verbatim from tokyonight.nvim's WezTerm extra;
  its bright variants duplicate the normals except `bright_black` and `bright_white`, and are ours.

`intellij-community`'s root `LICENSE.txt` is the **JetBrains Open-Source Build Terms v1.3**, which
govern the distributed IDE builds and state that the source they are assembled from is under the
Apache 2.0 License. The attribution therefore cites the source file, not `LICENSE.txt`. "JetBrains"
and "Darcula" are trademarks of JetBrains s.r.o.; Apache-2.0 grants no trademark rights, and the
theme name is used descriptively.

## `warp-defaults/` — 19 variants

### Apache-2.0 — 16 variants

Derived from the published Warp theme repository
[`warpdotdev/themes`](https://github.com/warpdotdev/themes) at commit
`82e51dcf9b47912d551107748ba3297a21b2eff3` (2026-08-03), which is licensed **Apache-2.0** per that
repository's `LICENSE`. The upstream files live under `warp_bundled/`. The repository's Apache-2.0
terms are the same as this repository's root [`LICENSE-APACHE`](../../../LICENSE-APACHE).

Each of these 16 was verified against its upstream YAML: all 16 `terminal_colors` values
(`normal` and `bright`) and `foreground` are identical.

Two documented adaptations were needed, because Zed's theme schema has no equivalent slot:

- Where Warp declares a **gradient** background (`{top, bottom}`), Zed's single `background`
  carries the midpoint of the two stops — `cyber-wave`, `dark-city`, `fancy-dracula`, `red-rock`,
  `snowy`, `willow-dream`.
- `dark` lifts Warp's pure-black `#000000` background to `#050505`.

| Local file | Upstream (`warp_bundled/`) | | Local file | Upstream (`warp_bundled/`) |
|---|---|---|---|---|
| `cyber-wave.json` | `cyber_wave.yaml` | | `light.json` | `warp_light.yaml` |
| `dark.json` | `warp_dark.yaml` | | `marble.json` | `marble.yaml` |
| `dark-city.json` | `dark_city.yaml` | | `pink-city.json` | `pink_city.yaml` |
| `dracula.json` | `dracula.yaml` | | `red-rock.json` | `red_rock.yaml` |
| `fancy-dracula.json` | `fancy_dracula.yaml` | | `snowy.json` | `snowy.yaml` |
| `jellyfish.json` | `jellyfish.yaml` | | `solarized-dark.json` | `solarized_dark.yaml` |
| `koi.json` | `koi.yaml` | | `solarized-light.json` | `solarized_light.yaml` |
| `leafy.json` | `leafy.yaml` | | `willow-dream.json` | `willow_dream.yaml` |

### AGPL-3.0-only — 3 variants

`adeberry.json`, `phenomenon.json`, and `solar-flare.json` have no counterpart in the public
`warpdotdev/themes` repository — checked across all 337 published themes, in `warp_bundled/`,
`standard/`, `base16/`, `special_edition/`, and `stradicat/`. They remain generated Zed adaptations
of the built-in themes in the local Warp app source at revision
`d33952fa9df2fa8d5ffc74ddd0939f322689dbb2`, which declares `AGPL-3.0-only`. That license text is
included as [`LICENSE-AGPL-3.0`](LICENSE-AGPL-3.0) and applies **only to these three files**.

Note that the public `base16/base16_solarflare.yaml` is a *different* palette from Warp's bundled
Solar Flare (`#18262f` / `#a6afb8` against this theme's `#1b1c18` / `#dde6ee`) and is therefore not
a substitute source for `solar-flare.json`.

## Not included

- **One Dark Pro** — the file shipped under this name did not match
  [`Binaryify/OneDark-Pro`](https://github.com/Binaryify/OneDark-Pro) (upstream is `#3f4451` /
  `#e05561` / `#8cc265`); its eight normal ANSI colours were identical to Zed's own bundled
  **One Dark**. It was misattributed and redundant, so it was removed rather than relabelled.
- **Dracula**, **Solarized Dark**, **Gruvbox Dark**, **Gruvbox Light** — each shipped twice, once
  from `popular-dark/` or `warp-defaults/` and once from an already-verified variant. One file per
  name was kept: the Warp-sourced Dracula and Solarized Dark, and Zed's own Gruvbox family.
- **Monokai Pro** — the public Monokai Pro repository describes a proprietary commercial theme and
  publishes no license, so there is no grant to redistribute it.
- **Warp referral themes** (`received-referral-reward`, `sent-referral-reward`) — Warp product
  marketing rather than editor themes.

The generated Zed JSON implementations are distributed as part of this Synth Zed fork under the
repository's licensing terms, subject to the upstream notices in [`../LICENSES`](../LICENSES).
