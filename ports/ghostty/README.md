# Moss Rose for Ghostty

From the repository root:

```sh
mkdir -p ~/.config/ghostty/themes
ln -s "$PWD/ports/ghostty/themes/moss-rose" "$PWD/ports/ghostty/themes/moss-rose-light" ~/.config/ghostty/themes/
```

Then in `~/.config/ghostty/config`, either one variant or both, following the system:

```
theme = moss-rose
# or: theme = light:moss-rose-light,dark:moss-rose
```

Reload with `ctrl+shift+,`. `ghostty +list-themes` should list both.

The files in `themes/` are generated from `palette.toml`; edit that, not these.
