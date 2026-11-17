"""WCAG contrast helpers."""
from dataclasses import dataclass
from typing import Iterable
import re

HEX = re.compile(r"^#[0-9a-f]{6}$", re.IGNORECASE)
MIN_RATIO = 4.5


@dataclass(frozen=True)
class Color:
    hex: str

    def __post_init__(self) -> None:
        if not HEX.match(self.hex):
            raise ValueError(f"not a hex color: {self.hex!r}")

    @property
    def luminance(self) -> float:
        channels = [int(self.hex[i:i + 2], 16) / 255 for i in (1, 3, 5)]
        r, g, b = (c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4 for c in channels)
        return 0.2126 * r + 0.7152 * g + 0.0722 * b


def ratio(fg: Color, bg: Color) -> float:
    hi, lo = sorted((fg.luminance, bg.luminance), reverse=True)
    return (hi + 0.05) / (lo + 0.05)


def failing(colors: Iterable[Color], bg: Color, *, minimum: float = MIN_RATIO) -> list[Color]:
    # Anything below the minimum is hard to read as body text.
    return [c for c in colors if ratio(c, bg) < minimum and c is not None]
