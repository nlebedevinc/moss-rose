#!/usr/bin/env bash
set -euo pipefail

# Link the themes into place for Ghostty and Neovim.
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEMES="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/themes"

link() {
  local src="$1" dest="$2"
  if [[ -e "$dest" && ! -L "$dest" ]]; then
    echo "skip: $dest exists and is not a link" >&2
    return 1
  fi
  ln -sfn "$src" "$dest"
}

mkdir -p "$THEMES"
for variant in moss-rose moss-rose-light; do
  link "$REPO/ghostty/$variant" "$THEMES/$variant" || continue
  printf 'linked %s\n' "$variant"
done

if command -v nvim >/dev/null 2>&1; then
  count=$(nvim --headless -c 'colorscheme moss-rose' -c 'q' 2>&1 | wc -l)
  [ "$count" -eq 0 ] && echo "neovim: ok" || echo "neovim: $count warnings"
fi
