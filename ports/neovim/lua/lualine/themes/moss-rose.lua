local p = require("moss-rose").palette()

local function mode(accent)
  return {
    a = { fg = p.base, bg = accent, gui = "bold" },
    b = { fg = accent, bg = p.surface },
    c = { fg = p.soft, bg = p.base },
  }
end

return {
  normal = mode(p.pine),
  insert = mode(p.foam),
  visual = mode(p.iris),
  replace = mode(p.love),
  command = mode(p.gold),
  terminal = mode(p.leaf),
  inactive = {
    a = { fg = p.faint, bg = p.base },
    b = { fg = p.faint, bg = p.base },
    c = { fg = p.faint, bg = p.base },
  },
}
