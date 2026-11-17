# Moss Rose for Neovim

Needs Neovim 0.9 or newer. The plugin lives in this folder, not at the repository root,
so point your plugin manager at the folder.

With lazy.nvim and a local checkout:

```lua
{
  dir = "~/dev/moss-rose/ports/neovim",  -- your clone of this repository,
  name = "moss-rose",
  lazy = false,
  priority = 1000,
  config = function()
    require("moss-rose").setup({
      variant = "auto",        -- follows 'background'; or "dark" / "light"
      transparent = false,     -- true: let the terminal background show through
      italic_comments = true,
      overrides = {},          -- e.g. { Comment = { fg = "#888888" } }
    })
    vim.cmd.colorscheme("moss-rose")
  end,
}
```

Without a plugin manager:

```lua
vim.opt.rtp:prepend(vim.fn.expand("~/dev/moss-rose/ports/neovim"))
vim.cmd.colorscheme("moss-rose")
```

`:colorscheme moss-rose` follows `'background'`; `:colorscheme moss-rose-light` forces the
light variant. A lualine theme is included:
`require("lualine").setup({ options = { theme = "moss-rose" } })`.

`lua/moss-rose/palettes/` is generated from `palette.toml`. Which highlight group gets
which color is hand-written in `lua/moss-rose/init.lua`.
