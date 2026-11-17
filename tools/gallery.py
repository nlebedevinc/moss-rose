"""Render samples/ into the preview page with Pygments.

This is an approximation of the themes: Pygments has its own token types, so
each one is mapped to the role the VS Code and Neovim ports give it. It shows
how the palette balances across languages. It does not prove that every
TextMate scope or Treesitter capture lands on the right rule; for that, open
the files in samples/ in the real editors.
"""
from html import escape
from pathlib import Path

from pygments import lex
from pygments.lexers import get_lexer_for_filename
from pygments.token import (Comment, Generic, Keyword, Name, Number, Operator, Punctuation,
                            String, Token)

ORDER = [
    "component.tsx", "contrast.py", "theme.rs", "server.go", "blend.c", "plugin.lua",
    "install.sh", "report.sql", "page.html", "style.css", "package.json", "ci.yaml",
    "config.toml", "Dockerfile", "notes.md", "change.diff",
]

# Most specific first. Classes are defined in preview.html.
BASE = [
    (Comment.Preproc, "m"), (Comment.PreprocFile, "s"), (Comment, "c"),
    (Keyword.Type, "t"), (Keyword.Constant, "b"), (Keyword, "k"),
    (Name.Function, "f"), (Name.Class, "t"), (Name.Exception, "t"),
    (Name.Builtin.Pseudo, "l"), (Name.Variable.Magic, "l"), (Name.Builtin, "f"),
    (Name.Decorator, "m"), (Name.Tag, "t"), (Name.Attribute, "a"), (Name.Constant, "n"),
    (Name.Label, "t"), (Name.Entity, "b"),
    (String.Escape, "b"), (String.Interpol, "b"), (String.Regex, "t"), (String.Doc, "c"),
    (String, "s"), (Number, "n"),
    (Operator.Word, "k"), (Operator, "o"), (Punctuation, "o"),
    (Generic.Heading, "h"), (Generic.Subheading, "h"), (Generic.Inserted, "gi"),
    (Generic.Deleted, "gd"), (Generic.Strong, "st"), (Generic.Emph, "em"),
]

# Where a Pygments lexer names things differently from the editor grammars.
PER_LEXER = {
    "CSS": [(Keyword.Constant, "n"), (Keyword, "t"), (Name.Class, "m"), (Name.Namespace, "m"),
            (Name.Decorator, "m"), (Name.Builtin, "f"), (Name.Function, "f")],
    "Diff": [(Generic.Heading, "m"), (Generic.Subheading, "m")],
    "TOML": [(Name, "t"), (Keyword, "h")],
    "Markdown": [(Name.Tag, "t"), (Name.Attribute, "lk"), (String.Backtick, "s"), (Keyword, "k")],
    "Docker": [(Name.Variable, "")],
    "Bash": [(Name.Builtin, "f"), (Name.Variable, "")],
    "SQL": [(Name.Builtin, "t")],
}


def role(lexer_name: str, ttype) -> str:
    for table in (PER_LEXER.get(lexer_name, []), BASE):
        for token, cls in table:
            if ttype in token:
                return cls
    return ""


def render(path: Path) -> str:
    lexer = get_lexer_for_filename(path.name, stripnl=False)
    lines, current = [], []
    for ttype, value in lex(path.read_text(), lexer):
        cls = "" if ttype in Token.Error else role(lexer.name, ttype)
        parts = value.split("\n")
        for i, part in enumerate(parts):
            if i:
                lines.append("".join(current))
                current = []
            if part:
                text = escape(part)
                current.append(f'<span class="{cls}">{text}</span>' if cls else text)
    if current:
        lines.append("".join(current))
    while lines and not lines[-1]:
        lines.pop()
    # No newlines between lines: each .ln is a block, so a newline would add a blank row.
    body = "".join(f'<span class="ln">{line}</span>' for line in lines)
    return (f'<figure class="win sample"><div class="bar"><div class="tab on">{escape(path.name)}</div>'
            f'<div class="tab lang">{escape(lexer.name)}</div></div>'
            f'<div class="code"><pre>{body}</pre></div></figure>')


def gallery_html(samples: Path) -> str:
    files = [samples / name for name in ORDER if (samples / name).exists()]
    files += sorted(p for p in samples.iterdir() if p.is_file() and p.name not in ORDER)
    return "\n".join(render(p) for p in files)
