#!/usr/bin/env python3
"""Regenerate every port from palette.toml.

    python3 tools/build.py

Each module in tools/ports/ is one app. It exposes build(themes), which returns
{path: content} for the files it generates under ports/<app>/. To support a new
app, add a module there and a folder under ports/; nothing else needs to change.
"""
import importlib
import pkgutil
import sys
from pathlib import Path

sys.dont_write_bytecode = True
TOOLS = Path(__file__).resolve().parent
ROOT = TOOLS.parent
sys.path.insert(0, str(TOOLS))

import palette  # noqa: E402
import ports    # noqa: E402
import preview  # noqa: E402


def main() -> None:
    themes = palette.load()
    for info in sorted(pkgutil.iter_modules(ports.__path__), key=lambda m: m.name):
        port = importlib.import_module(f"ports.{info.name}")
        for rel, content in port.build(themes).items():
            path = ROOT / "ports" / info.name / rel
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(content)
            print(f"wrote {path.relative_to(ROOT)}")
    page = ROOT / "docs" / "preview.html"
    if preview.update(page, themes, ROOT / "samples"):
        print(f"wrote {page.relative_to(ROOT)}")
    else:
        print(f"wrote {page.relative_to(ROOT)} (palettes only: install pygments to refresh the language gallery)")


if __name__ == "__main__":
    main()
