# Synth fork icon sources — Zed + Warp

The vector masters that every shipped app icon is rendered from, for both this
checkout and the sibling `../warp` checkout. Started from the JetBrains Darcula
concepts explored in https://github.com/synthet/zed/pull/3; the marks survived
that exploration, the plate did not.

## The plate

Flat `#101014`, inset `64/1024`, corner radius `184`, **transparent surround** —
the same construction Cursor and Photoshop use. Deliberately no gradient, no
accent rim, no bevel.

The transparent surround is the point. The previous Warp rasters were opaque all
the way to the canvas edge, so Windows drew a hard black frame around the tile.
`check_transparent_surround()` in `script/apply_branding_icons.py` now probes all
four corners and all four edge midpoints of every emitted PNG and ICO frame, so
that defect cannot come back silently.

## Palette

| Role | Colour |
| --- | --- |
| Plate | `#101014` |
| Glyph, flat (Windows, small sizes) | `#A9B7C6` |
| Glyph highlight (macOS gradient top) | `#F8FAFC` |
| Preview channel tint | `#6897BB` |
| Nightly channel tint | `#9876AA` |
| Dev channel tint | `#CC7832` |

Glyph colour is the only thing that varies between Zed's release channels. The
plate and the mark stay identical across all four.

## Masters

| App | macOS (silver gradient) | Windows (flat silver) |
| --- | --- | --- |
| Zed | [SVG](zed-macos.svg) / [PNG](zed-macos.png) | [SVG](zed-windows.svg) / [PNG](zed-windows.png) |
| Warp | [SVG](warp-macos.svg) / [PNG](warp-macos.png) | [SVG](warp-windows.svg) / [PNG](warp-windows.png) |

Zed is a bracketed Z; Warp is the two-panel mark. They stay distinguishable in
grayscale and at 16 px, so colour is never the differentiator.

Both marks are tuned to the same visual weight, which is what makes them read as
a set. The first cut of Zed was a five-ring labyrinth: its *total* ink matched
Warp almost exactly (21.9% of the plate against 24.4%), but it spread that ink
over five hairlines and looked far lighter and busier on the desktop. The measure
that actually tracks the mismatch is horizontal glyph/plate transitions per
scanline — 4.44 for the labyrinth against Warp's 1.56. Reducing it to two open
brackets and one diagonal brings it to 2.29 at 23.5% ink, and the two finally
look related. A five-ring labyrinth cannot be made to match two solid panels
without ceasing to be a labyrinth; the brackets keep the frame-and-diagonal
character at a weight that pairs.

Both glyphs also sit in a comparable box — Zed at 240..784, Warp at 222..806 —
so neither runs to the plate edge while the other has margin.

## Small-size variants

Sizes at or below 32 px render from hand-simplified sources with grid-snapped
geometry, so bars land on whole pixels instead of straddling them:

| Source | Used for | Reduction |
| --- | --- | --- |
| [zed-small-32.svg](zed-small-32.svg) | Zed 24 and 32 px | Same bracketed Z, bars widened to 96 units |
| [zed-small-16.svg](zed-small-16.svg) | Zed 16 px | Brackets dropped, bold Z on a 64-unit grid |
| [warp-small-32.svg](warp-small-32.svg) | Warp 16, 24 and 32 px | Same panels, inter-panel gap widened |

`source_for()` in `script/apply_branding_icons.py` picks between them. Renders
happen at the target size rather than by downscaling from 1024, so grid-snapped
edges land on whole pixels.

## Regenerating

Shipped icons for both checkouts:

```sh
uv run --with pillow python script/apply_branding_icons.py           # Zed + Warp
uv run --with pillow python script/apply_branding_icons.py --zed-only
uv run --with pillow python script/apply_branding_icons.py --check   # validate, no writes
```

The comparison sheet and the 1024 px master PNGs:

```sh
python assets/branding/jetbrains-darcula-concepts/build.py
```

Both need ImageMagick 7 with SVG support on `PATH` (verified against 7.1.2 with
librsvg). `build.py` validates the masters, prefixes SVG IDs per sheet instance,
and renders straight from vectors — `comparison-sheet.svg` is generated, so edit
`build.py` for layout, not the sheet.

## Still outstanding

Icon Composer files, an `.icns`, and native OS validation on macOS. Warp's
macOS `AppIcon.icon/` adaptive bundles and its DockTilePlugin variants are a
separate icon system and are not produced here.

The original raster exploration's prompts are kept in [prompts.json](prompts.json)
as design history, not as a build input. The SVG geometry is a reconstruction of
those shapes, not a pixel-exact trace.
