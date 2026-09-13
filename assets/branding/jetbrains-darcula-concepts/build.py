"""Compose the vector comparison sheet and render PNGs from editable SVG masters."""

from pathlib import Path
import copy
import shutil
import subprocess
import xml.etree.ElementTree as ET


ROOT = Path(__file__).resolve().parent
SVG = "http://www.w3.org/2000/svg"
ET.register_namespace("", SVG)
NAMES = ("zed-macos", "warp-macos", "zed-windows", "warp-windows")
LABELS = ("Zed / macOS", "Warp / macOS", "Zed / Windows", "Warp / Windows")


def element(parent, tag, **attributes):
    return ET.SubElement(
        parent,
        f"{{{SVG}}}{tag}",
        {key.replace("_", "-"): str(value) for key, value in attributes.items()},
    )


def text(parent, x, y, content, size=22, anchor="start", fill="#A9B7C6"):
    node = element(
        parent,
        "text",
        x=x,
        y=y,
        font_size=size,
        text_anchor=anchor,
        font_family="Segoe UI, Arial, sans-serif",
        fill=fill,
    )
    node.text = content


def read_master(name):
    root = ET.parse(ROOT / f"{name}.svg").getroot()
    if root.get("viewBox") != "0 0 1024 1024":
        raise ValueError(f"{name}: expected a 1024-unit square viewBox")
    for node in root.iter():
        tag = node.tag.split("}")[-1]
        if tag in {"image", "script", "foreignObject"}:
            raise ValueError(f"{name}: forbidden non-vector element {tag}")
        for value in node.attrib.values():
            if "data:" in value or "http:" in value or "https:" in value:
                raise ValueError(f"{name}: external or raster reference")
    return root


def insert_icon(parent, master, x, y, size, prefix):
    icon = copy.deepcopy(master)
    icon.attrib.update(x=str(x), y=str(y), width=str(size), height=str(size))
    icon.attrib.pop("aria-labelledby", None)
    for child in list(icon):
        if child.get("id") == "background" or child.tag.split("}")[-1] in {
            "title",
            "desc",
        }:
            icon.remove(child)
    ids = {
        node.get("id"): prefix + node.get("id")
        for node in icon.iter()
        if node.get("id")
    }
    for node in icon.iter():
        for key, value in list(node.attrib.items()):
            if key == "id":
                node.set(key, ids[value])
            else:
                for original, replacement in ids.items():
                    value = value.replace(f"url(#{original})", f"url(#{replacement})")
                node.set(key, value)
    parent.append(icon)


def comparison_sheet(masters):
    sheet = ET.Element(
        f"{{{SVG}}}svg", width="1536", height="1024", viewBox="0 0 1536 1024"
    )
    element(sheet, "title").text = "Zed + Warp — JetBrains Darcula icon family"
    element(sheet, "rect", width=1536, height=1024, fill="#2B2B2B")
    text(sheet, 768, 99, "Zed + Warp", 76, "middle", "#D8E0EA")
    text(
        sheet, 768, 146, "JetBrains Darcula · Editable vector icon family", 24, "middle"
    )
    for index, (master, label) in enumerate(zip(masters, LABELS)):
        x = 48 + index * 372
        insert_icon(sheet, master, x, 190, 324, f"hero-{index}-")
        text(sheet, x + 162, 551, label, 24, "middle")
    element(sheet, "path", d="M 64 585 H 1472", stroke="#44474A", fill="none")
    text(
        sheet,
        768,
        626,
        "Small-size previews · 64 px and 32 px at native sheet size",
        22,
        "middle",
    )
    for index, master in enumerate(masters):
        x = 64 + index * 372
        for size, offset in ((64, 80), (32, 184)):
            insert_icon(
                sheet,
                master,
                x + offset,
                650 + (64 - size),
                size,
                f"small-{index}-{size}-",
            )
            text(sheet, x + offset + size / 2, 744, str(size), 16, "middle")
    element(sheet, "path", d="M 64 779 H 1472", stroke="#44474A", fill="none")
    text(sheet, 64, 822, "Palette", 22)
    for index, color in enumerate(
        ("#2B2B2B", "#353637", "#A9B7C6", "#CC7832", "#9876AA", "#6897BB")
    ):
        x = 64 + index * 104
        element(
            sheet,
            "rect",
            x=x,
            y=851,
            width=76,
            height=66,
            rx=10,
            fill=color,
            stroke="#575C61",
        )
        text(sheet, x + 38, 945, color, 15, "middle")
    for label, x, start in (("Dock concept", 786, 0), ("Taskbar concept", 1170, 2)):
        text(sheet, x + 121, 822, label, 22, "middle")
        element(
            sheet,
            "rect",
            x=x,
            y=850,
            width=242,
            height=104,
            rx=20,
            fill="#353637",
            stroke="#44474A",
        )
        for index in range(2):
            insert_icon(
                sheet,
                masters[start + index],
                x + 31 + index * 106,
                866,
                72,
                f"context-{start}-{index}-",
            )
    text(
        sheet,
        1472,
        997,
        "Vector sources · Badges removed · Native packaging pending",
        16,
        "end",
    )
    ET.indent(sheet, space="  ")
    ET.ElementTree(sheet).write(
        ROOT / "comparison-sheet.svg", encoding="utf-8", xml_declaration=True
    )


def main():
    magick = shutil.which("magick")
    if not magick:
        raise SystemExit("Install ImageMagick with SVG support and put magick on PATH.")
    masters = [read_master(name) for name in NAMES]
    comparison_sheet(masters)
    for name in (*NAMES, "comparison-sheet"):
        source = ROOT / f"{name}.svg"
        output = ROOT / f"{name}.png"
        subprocess.run(
            [magick, "-background", "none", str(source), "-strip", str(output)],
            check=True,
        )
        subprocess.run(
            [magick, "identify", "-format", "%f: %wx%h %[channels]\n", str(output)],
            check=True,
        )
    print("Validated four vector masters; rebuilt comparison SVG and five PNGs.")


if __name__ == "__main__":
    main()
