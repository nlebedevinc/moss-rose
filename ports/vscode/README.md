# Moss Rose for VS Code

From the repository root:

```sh
ln -s "$PWD/ports/vscode" ~/.vscode/extensions/nlebedevinc.moss-rose-0.2.0
```

Restart VS Code, then *Preferences: Color Theme* → **Moss Rose** or **Moss Rose Light**.
For Cursor or VSCodium the folder is `~/.cursor/extensions` or `~/.vscode-oss/extensions`.

To build an installable `.vsix` instead:

```sh
cd ports/vscode && npx @vscode/vsce package
```

The files in `themes/` are generated from `palette.toml` by `tools/ports/vscode.py`; edit
those, not the JSON. `package.json` is hand-written.
