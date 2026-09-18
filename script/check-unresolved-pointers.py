#!/usr/bin/env python3
"""Fail if a built Windows binary contains unresolved pointer slots.

Link-time optimization can drop `#[no_mangle] extern "C"` definitions that only
C code references, because the C objects are compiled outside the LTO unit. When
that happens the linker may bind those references to RVA 0 rather than erroring.
A relocated RVA 0 reads back as the image base at runtime, so calling through
such a slot jumps into the PE header and dies with a DEP access violation.

This checks every 64-bit base relocation in the image and reports any slot whose
value is exactly the image base, which is never a meaningful pointer.

Usage:
    script/check-unresolved-pointers.py [path-to-exe]

Defaults to target/release/zed.exe. Exits non-zero if any unresolved slot is
found.
"""

import struct
import sys
from pathlib import Path

IMAGE_REL_BASED_DIR64 = 10
PE32_PLUS_MAGIC = 0x20B


class Image:
    def __init__(self, path: Path):
        self.data = path.read_bytes()
        self.path = path

        if self.data[:2] != b"MZ":
            raise ValueError(f"{path} is not a PE image")
        pe = struct.unpack_from("<I", self.data, 0x3C)[0]
        if self.data[pe : pe + 4] != b"PE\0\0":
            raise ValueError(f"{path} is not a PE image")

        section_count = struct.unpack_from("<H", self.data, pe + 6)[0]
        optional_size = struct.unpack_from("<H", self.data, pe + 20)[0]
        optional = pe + 24

        magic = struct.unpack_from("<H", self.data, optional)[0]
        if magic != PE32_PLUS_MAGIC:
            raise ValueError(f"{path} is not a 64-bit PE image")
        self.image_base = struct.unpack_from("<Q", self.data, optional + 24)[0]

        self.sections = []
        for i in range(section_count):
            offset = optional + optional_size + i * 40
            name = self.data[offset : offset + 8].rstrip(b"\0").decode("ascii", "replace")
            virtual_size, virtual_address, raw_size, raw_offset = struct.unpack_from(
                "<IIII", self.data, offset + 8
            )
            self.sections.append((name, virtual_address, virtual_size, raw_offset, raw_size))

    def section_of(self, rva):
        for name, va, virtual_size, _, raw_size in self.sections:
            if va <= rva < va + max(virtual_size, raw_size):
                return name
        return None

    def read_u64(self, rva):
        for _, va, virtual_size, raw_offset, raw_size in self.sections:
            if va <= rva < va + max(virtual_size, raw_size):
                offset = raw_offset + (rva - va)
                if offset + 8 > len(self.data) or rva - va >= raw_size:
                    return None
                return struct.unpack_from("<Q", self.data, offset)[0]
        return None

    def dir64_relocations(self):
        reloc = next((s for s in self.sections if s[0] == ".reloc"), None)
        if reloc is None:
            return
        _, _, _, raw_offset, raw_size = reloc
        block = raw_offset
        end = raw_offset + raw_size
        while block + 8 <= end:
            page, size = struct.unpack_from("<II", self.data, block)
            if size < 8 or block + size > end:
                break
            for i in range((size - 8) // 2):
                entry = struct.unpack_from("<H", self.data, block + 8 + i * 2)[0]
                if entry >> 12 == IMAGE_REL_BASED_DIR64:
                    yield page + (entry & 0xFFF)
            block += size


def main():
    path = Path(sys.argv[1] if len(sys.argv) > 1 else "target/release/zed.exe")
    if not path.is_file():
        print(f"error: {path} not found", file=sys.stderr)
        return 2

    image = Image(path)
    unresolved = [
        rva for rva in image.dir64_relocations() if image.read_u64(rva) == image.image_base
    ]

    if not unresolved:
        print(f"ok: {path} has no unresolved pointer slots")
        return 0

    print(
        f"error: {path} has {len(unresolved)} unresolved pointer slot(s) "
        f"holding the image base (0x{image.image_base:x}).",
        file=sys.stderr,
    )
    print(
        "These are symbols the linker resolved to RVA 0. Calling through one "
        "crashes with a DEP access violation at the image base.",
        file=sys.stderr,
    )

    unresolved.sort()
    runs = []
    for rva in unresolved:
        if runs and rva == runs[-1][0] + runs[-1][1] * 8:
            runs[-1][1] += 1
        else:
            runs.append([rva, 1])

    for start, count in runs:
        section = image.section_of(start) or "?"
        print(f"  {section} rva 0x{start:08x}  x{count} slot(s)", file=sys.stderr)

    return 1


if __name__ == "__main__":
    sys.exit(main())
