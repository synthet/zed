# JetBrains Darcula fork icon concepts

Editable SVG artwork based on the supplied mockup and the icon-system plan
associated with https://github.com/synthet/zed/pull/3. The circular fork badges
have been removed from every icon and preview.

The geometry follows the mockup's recognizable Zed/Warp marks.
This differs from the plan's original Dracula Prism silhouettes. The palette
reference is the repository's `assets/themes/synthet/popular-dark/jetbrains-darcula.json`:
charcoal #2B2B2B, surface #353637, silver #A9B7C6, copper #CC7832,
violet #9876AA, and blue #6897BB. macOS sources add restrained vector gradients
and an offset glyph shadow; Windows glyphs use flat silver fills.

| App | macOS material concept | Windows flat concept |
| --- | --- | --- |
| Zed | [SVG](zed-macos.svg) / [PNG](zed-macos.png) | [SVG](zed-windows.svg) / [PNG](zed-windows.png) |
| Warp | [SVG](warp-macos.svg) / [PNG](warp-macos.png) | [SVG](warp-windows.svg) / [PNG](warp-windows.png) |

[Comparison sheet SVG](comparison-sheet.svg) / [PNG](comparison-sheet.png)
includes 64/32 px previews, palette swatches, and conceptual Dock/taskbar rows.
The sheet embeds the same vector geometry as the masters, with no linked or
embedded bitmaps. Preview sizes are exact at the sheet's native 1536 x 1024 size.

Edit the four 1024 x 1024 SVG masters in any SVG editor. Named groups separate
the background, foundation, accent rim, shadow (macOS), and glyph. Hide or remove
the `background` group to make the area outside the icon transparent.

Regenerate the comparison SVG and all five PNGs using Python 3 and ImageMagick
with SVG support (verified with ImageMagick 7 and librsvg):

```sh
python assets/branding/jetbrains-darcula-concepts/build.py
```

Alternatively, with uv:

```sh
uv run --no-project --python 3.12 python assets/branding/jetbrains-darcula-concepts/build.py
```

The build validates the masters, prefixes SVG IDs for each sheet instance, and
renders PNGs directly from vectors. Edit `build.py` for sheet layout and labels;
`comparison-sheet.svg` is generated. The named backgrounds are intentionally
opaque for these previews. Font rendering uses Segoe UI, Arial, or sans-serif.

Icon Composer files, ICNS, ICO, dedicated small-size geometry, and native OS
validation remain outstanding. Existing application resources were not replaced.

The original raster exploration used built-in image generation; its prompts are
retained in [prompts.json](prompts.json) as design history, not the build source.
The editable SVGs now define the delivered artwork. Their geometric reconstruction
simplifies the original raster shading and is not a pixel-exact trace.
