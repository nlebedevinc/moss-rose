"""Neovim: one generated palette per variant.

What each color is used for is hand-written in ports/neovim/lua/moss-rose/init.lua.
"""


def palette_file(t) -> str:
    out = ["-- Generated from palette.toml by tools/build.py. Do not edit.", "return {"]
    out.append(f'  variant = "{t.variant}",')
    out += [f'  {k} = "{v}",' for k, v in {**t.colors, **t.tints}.items()]
    out.append('  none = "NONE",')
    out.append("  ansi = {")
    out += [f'    "{c}",' for c in t.ansi]
    out += ["  },", "}", ""]
    return "\n".join(out)


def build(themes) -> dict:
    return {f"lua/moss-rose/palettes/{t.variant}.lua": palette_file(t) for t in themes}
