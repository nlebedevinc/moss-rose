"""Fill the generated parts of docs/preview.html: both palettes and the language gallery."""
import re
from pathlib import Path


def css_vars(t, indent: str = "  ") -> str:
    lines = [f"{indent}--{k.replace('_', '-')}: {v};" for k, v in t.colors.items()]
    lines += [f"{indent}--ansi-{i}: {c};" for i, c in enumerate(t.ansi)]
    return "\n".join(lines)


def fill(html: str, marker: str, content: str) -> str:
    """Replace what sits between `marker:start` and `marker:end` comments."""
    pattern = (rf"(/\* {marker}:start \*/|<!-- {marker}:start -->)\n(?:.*?\n)??"
               rf"([ \t]*(?:/\* {marker}:end \*/|<!-- {marker}:end -->))")
    out, n = re.subn(pattern, lambda m: m.group(1) + "\n" + content + "\n" + m.group(2), html, flags=re.S)
    assert n == 1, f"marker {marker} not found in the preview page"
    return out


def update(path: Path, themes, samples: Path) -> bool:
    html = path.read_text()
    by_variant = {t.variant: t for t in themes}
    html = fill(html, "palette", css_vars(by_variant["dark"]))
    html = fill(html, "palette-light", css_vars(by_variant["light"]))
    try:
        from gallery import gallery_html
        html = fill(html, "gallery", gallery_html(samples))
        complete = True
    except ImportError:
        complete = False  # Pygments missing: leave the gallery as it was
    path.write_text(html)
    return complete
