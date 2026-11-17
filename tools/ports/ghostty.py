"""Ghostty: one theme file per variant."""


def theme_file(t) -> str:
    p = t.colors
    lines = [
        f"# {t.name}: Rosé Pine syntax hues on a Vitesse canvas.",
        "# Generated from palette.toml by tools/build.py.",
        "",
    ]
    lines += [f"palette = {i}={c}" for i, c in enumerate(t.ansi)]
    lines += [
        "",
        f"background = {p['base']}",
        f"foreground = {p['text']}",
        f"cursor-color = {p['pine']}",
        f"cursor-text = {p['base']}",
        f"selection-background = {p['select']}",
        f"selection-foreground = {p['text']}",
        "",
    ]
    return "\n".join(lines)


def build(themes) -> dict:
    return {f"themes/{t.slug}": theme_file(t) for t in themes}
