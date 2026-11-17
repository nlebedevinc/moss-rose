"""Load palette.toml and derive everything the ports need from it."""
import tomllib
from dataclasses import dataclass, field
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def blend(color: str, base: str, amount: float) -> str:
    """Mix `color` into `base`: 0 is all base, 1 is all color."""
    c = [int(color[i:i + 2], 16) for i in (1, 3, 5)]
    b = [int(base[i:i + 2], 16) for i in (1, 3, 5)]
    return "#" + "".join(f"{round(x * amount + y * (1 - amount)):02x}" for x, y in zip(c, b))


def alpha(color: str, aa: str) -> str:
    """Append a two-digit hex alpha to a #rrggbb color."""
    return color + aa


@dataclass
class Theme:
    variant: str   # "dark" or "light"
    name: str      # "Moss Rose"
    slug: str      # "moss-rose"
    colors: dict   # the named colors from palette.toml
    bright: dict = field(default_factory=dict)  # overrides for ANSI 9-15

    @property
    def tints(self) -> dict:
        """Tinted backgrounds for apps that have no alpha (terminals, Neovim)."""
        p, base = self.colors, self.colors["base"]
        return {
            "diff_add": blend(p["pine"], base, 0.20),
            "diff_change": blend(p["sky"], base, 0.16),
            "diff_delete": blend(p["love"], base, 0.18),
            "diff_text": blend(p["sky"], base, 0.36),
            "search": blend(p["gold"], base, 0.32),
            "error_bg": blend(p["love"], base, 0.12),
            "warn_bg": blend(p["gold"], base, 0.12),
            "info_bg": blend(p["sky"], base, 0.12),
            "hint_bg": blend(p["leaf"], base, 0.12),
        }

    @property
    def ansi(self) -> list:
        """The 16 terminal colors."""
        p, b = self.colors, self.bright
        hue = lambda k: b.get(k, p[k])
        if self.variant == "dark":
            black, white, bright_black, bright_white = p["hl_high"], p["text"], p["muted"], b["text"]
        else:
            black, white, bright_black, bright_white = p["text"], p["subtle"], p["muted"], p["faint"]
        return [
            black, p["love"], p["leaf"], p["gold"], p["sky"], p["iris"], p["foam"], white,
            bright_black, hue("love"), hue("leaf"), hue("gold"), hue("sky"), hue("iris"),
            hue("foam"), bright_white,
        ]


def load(path: Path = ROOT / "palette.toml") -> list[Theme]:
    data = tomllib.loads(path.read_text())
    return [
        Theme(variant=v["variant"], name=v["name"], slug=v["slug"],
              colors=v["colors"], bright=v.get("bright", {}))
        for v in data["theme"]
    ]
