-- lazy.nvim spec for the theme
local M = {}

local defaults = {
  variant = "auto",
  transparent = false,
  italic_comments = true,
}

---@param opts table|nil
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", defaults, opts or {})
  if M.options.variant ~= "auto" and not vim.tbl_contains({ "dark", "light" }, M.options.variant) then
    error(("unknown variant: %s"):format(M.options.variant))
  end
  for i = 1, #M.hooks do
    M.hooks[i](M.options)
  end
  vim.cmd.colorscheme("moss-rose")
  return true
end

return M
