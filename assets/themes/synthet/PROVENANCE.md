# Synthet bundled themes

This directory adds 29 Zed theme variants from the cross-app `synthet-theme` artifact library.
Together with the 11 Ayu, Gruvbox, and One variants already under `assets/themes`, that is 40
theme variants in total. The existing 11 Zed-sourced variants retain their established names and
byte-identical bundled files.

## Naming

The imported variants use **plain display names** — `Koi`, `Catppuccin Mocha`, `Tokyo Night` — with
no source prefix, matching the names their upstreams use.

Four names are consequently shared by more than one variant, so the 40 variants present **36
distinct theme names** and the theme picker offers 36 entries:

| Name | Files sharing it |
|---|---|
| `Dracula` | `popular-dark/dracula.json`, `warp-defaults/dracula.json` |
| `Gruvbox Dark` | `../gruvbox/`, `warp-defaults/gruvbox-dark.json` |
| `Gruvbox Light` | `../gruvbox/`, `warp-defaults/gruvbox-light.json` |
| `Solarized Dark` | `popular-dark/solarized-dark.json`, `warp-defaults/solarized-dark.json` |

`theme_settings::load_bundled_themes` inserts families into the registry in asset-listing order, so
for each of those four names the last file loaded is the one that ends up selectable. Rename the
variants if both need to be reachable.

## `popular-dark/` — 8 variants

Generated Zed implementations based on the catalog's pinned upstream theme research. Dracula,
Catppuccin, GitHub Dark, Nord, One Dark Pro, Solarized, and Tokyo Night sources are MIT;
JetBrains Darcula is Apache-2.0.

## `warp-defaults/` — 21 variants

### Apache-2.0 — 18 variants

Derived from the published Warp theme repository
[`warpdotdev/themes`](https://github.com/warpdotdev/themes) at commit
`82e51dcf9b47912d551107748ba3297a21b2eff3` (2026-08-03), which is licensed **Apache-2.0** per that
repository's `LICENSE`. The upstream files live under `warp_bundled/`. The repository's Apache-2.0
terms are the same as this repository's root [`LICENSE-APACHE`](../../../LICENSE-APACHE).

Each of these 18 was verified against its upstream YAML: all 16 `terminal_colors` values
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
| `gruvbox-dark.json` | `gruvbox_dark.yaml` | | `solarized-dark.json` | `solarized_dark.yaml` |
| `gruvbox-light.json` | `gruvbox_light.yaml` | | `solarized-light.json` | `solarized_light.yaml` |
| `jellyfish.json` | `jellyfish.yaml` | | `willow-dream.json` | `willow_dream.yaml` |
| `koi.json` | `koi.yaml` | | | |
| `leafy.json` | `leafy.yaml` | | | |

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

- **Monokai Pro** — the public Monokai Pro repository describes a proprietary commercial theme and
  publishes no license, so there is no grant to redistribute it.
- **Warp referral themes** (`received-referral-reward`, `sent-referral-reward`) — Warp product
  marketing rather than editor themes.

The generated Zed JSON implementations are distributed as part of this Synth Zed fork under the
repository's licensing terms, subject to the upstream notices above.
