-- Moss Rose: Rosé Pine syntax hues on a Vitesse canvas, dark and light.
local M = {}

M.options = {
  variant = "auto", -- "auto" follows 'background'; or force "dark" / "light"
  transparent = false, -- let the terminal background show through
  italic_comments = true,
  overrides = {}, -- { GroupName = { fg = "#rrggbb", ... } } or function(palette) -> table
}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

local function groups(p, o)
  local bg = o.transparent and p.none or p.base
  local float_bg = o.transparent and p.none or p.overlay

  return {
    -- ── Editor ────────────────────────────────────────────────────────────
    Normal = { fg = p.text, bg = bg },
    NormalNC = { fg = p.text, bg = bg },
    NormalFloat = { fg = p.text, bg = float_bg },
    FloatBorder = { fg = p.line, bg = float_bg },
    FloatTitle = { fg = p.leaf, bg = float_bg, bold = true },
    ColorColumn = { bg = p.surface },
    Conceal = { fg = p.faint },
    Cursor = { fg = p.base, bg = p.pine },
    lCursor = { link = "Cursor" },
    CursorIM = { link = "Cursor" },
    TermCursor = { link = "Cursor" },
    CursorLine = { bg = p.surface },
    CursorColumn = { bg = p.surface },
    CursorLineNr = { fg = p.subtle },
    LineNr = { fg = p.faint },
    SignColumn = { fg = p.faint, bg = bg },
    FoldColumn = { fg = p.faint, bg = bg },
    Folded = { fg = p.subtle, bg = p.surface },
    EndOfBuffer = { fg = p.base },
    NonText = { fg = p.hl_high },
    Whitespace = { fg = p.hl_med },
    SpecialKey = { fg = p.faint },
    Directory = { fg = p.foam },
    Title = { fg = p.leaf, bold = true },
    Visual = { bg = p.select },
    VisualNOS = { link = "Visual" },
    Search = { fg = p.text, bg = p.search },
    IncSearch = { fg = p.base, bg = p.gold },
    CurSearch = { link = "IncSearch" },
    Substitute = { fg = p.base, bg = p.love },
    MatchParen = { fg = p.text, bg = p.select, bold = true },
    WinSeparator = { fg = p.line },
    VertSplit = { link = "WinSeparator" },
    StatusLine = { fg = p.soft, bg = p.surface },
    StatusLineNC = { fg = p.faint, bg = bg },
    WinBar = { fg = p.subtle, bg = bg },
    WinBarNC = { fg = p.faint, bg = bg },
    TabLine = { fg = p.subtle, bg = bg },
    TabLineFill = { bg = bg },
    TabLineSel = { fg = p.text, bg = p.surface },
    Pmenu = { fg = p.soft, bg = p.overlay },
    PmenuSel = { fg = p.text, bg = p.hl_med },
    PmenuSbar = { bg = p.overlay },
    PmenuThumb = { bg = p.hl_high },
    PmenuKind = { fg = p.foam, bg = p.overlay },
    PmenuExtra = { fg = p.faint, bg = p.overlay },
    WildMenu = { link = "PmenuSel" },
    QuickFixLine = { bg = p.select },
    ModeMsg = { fg = p.subtle },
    MoreMsg = { fg = p.leaf },
    MsgArea = { fg = p.text },
    Question = { fg = p.gold },
    ErrorMsg = { fg = p.love },
    WarningMsg = { fg = p.gold },
    SpellBad = { sp = p.love, undercurl = true },
    SpellCap = { sp = p.gold, undercurl = true },
    SpellLocal = { sp = p.sky, undercurl = true },
    SpellRare = { sp = p.iris, undercurl = true },

    -- ── Diff ──────────────────────────────────────────────────────────────
    DiffAdd = { bg = p.diff_add },
    DiffChange = { bg = p.diff_change },
    DiffDelete = { fg = p.love, bg = p.diff_delete },
    DiffText = { bg = p.diff_text },
    Added = { fg = p.leaf },
    Changed = { fg = p.sky },
    Removed = { fg = p.love },
    diffAdded = { fg = p.leaf },
    diffRemoved = { fg = p.love },
    diffChanged = { fg = p.sky },
    diffFile = { fg = p.foam },
    diffLine = { fg = p.iris },
    diffIndexLine = { fg = p.faint },

    -- ── Syntax (legacy groups; Treesitter links into these) ───────────────
    Comment = { fg = p.muted, italic = o.italic_comments },
    Constant = { fg = p.gold },
    String = { fg = p.gold },
    Character = { fg = p.gold },
    Number = { fg = p.gold },
    Float = { fg = p.gold },
    Boolean = { fg = p.rose },
    Identifier = { fg = p.text },
    Function = { fg = p.rose },
    Statement = { fg = p.leaf },
    Conditional = { fg = p.leaf },
    Repeat = { fg = p.leaf },
    Label = { fg = p.foam },
    Operator = { fg = p.subtle },
    Keyword = { fg = p.leaf },
    Exception = { fg = p.leaf },
    PreProc = { fg = p.iris },
    Include = { fg = p.leaf },
    Define = { fg = p.iris },
    Macro = { fg = p.iris },
    PreCondit = { fg = p.iris },
    Type = { fg = p.foam },
    StorageClass = { fg = p.leaf },
    Structure = { fg = p.foam },
    Typedef = { fg = p.foam },
    Special = { fg = p.rose },
    SpecialChar = { fg = p.rose },
    Tag = { fg = p.foam },
    Delimiter = { fg = p.subtle },
    SpecialComment = { fg = p.iris, italic = true },
    Debug = { fg = p.rose },
    Underlined = { fg = p.sky, underline = true },
    Bold = { bold = true },
    Italic = { italic = true },
    Ignore = { fg = p.faint },
    Error = { fg = p.love },
    Todo = { fg = p.base, bg = p.gold, bold = true },

    -- ── Treesitter ────────────────────────────────────────────────────────
    ["@variable"] = { fg = p.text },
    ["@variable.builtin"] = { fg = p.rose, italic = true },
    ["@variable.parameter"] = { fg = p.iris },
    ["@variable.parameter.builtin"] = { fg = p.iris, italic = true },
    ["@variable.member"] = { fg = p.text },
    ["@property"] = { fg = p.text },
    -- keys in data and style files keep a color, so the structure stays visible
    ["@property.json"] = { fg = p.foam },
    ["@property.jsonc"] = { fg = p.foam },
    ["@property.json5"] = { fg = p.foam },
    ["@property.yaml"] = { fg = p.foam },
    ["@property.toml"] = { fg = p.foam },
    ["@property.ini"] = { fg = p.foam },
    ["@property.css"] = { fg = p.foam },
    ["@property.scss"] = { fg = p.foam },
    ["@constant"] = { fg = p.gold },
    ["@constant.builtin"] = { fg = p.rose },
    ["@constant.macro"] = { fg = p.iris },
    ["@module"] = { fg = p.text },
    ["@module.builtin"] = { fg = p.text, italic = true },
    ["@label"] = { fg = p.foam },
    ["@string"] = { fg = p.gold },
    ["@string.documentation"] = { fg = p.muted, italic = true },
    ["@string.regexp"] = { fg = p.foam },
    ["@string.escape"] = { fg = p.rose },
    ["@string.special"] = { fg = p.rose },
    ["@string.special.symbol"] = { fg = p.iris },
    ["@string.special.url"] = { fg = p.sky, underline = true },
    ["@string.special.path"] = { fg = p.foam },
    ["@character"] = { fg = p.gold },
    ["@character.special"] = { fg = p.rose },
    ["@boolean"] = { fg = p.rose },
    ["@number"] = { fg = p.gold },
    ["@number.float"] = { fg = p.gold },
    ["@type"] = { fg = p.foam },
    ["@type.builtin"] = { fg = p.foam },
    ["@type.definition"] = { fg = p.foam },
    ["@attribute"] = { fg = p.iris },
    ["@attribute.builtin"] = { fg = p.iris },
    ["@function"] = { fg = p.rose },
    ["@function.builtin"] = { fg = p.rose },
    ["@function.call"] = { fg = p.rose },
    ["@function.macro"] = { fg = p.iris },
    ["@function.method"] = { fg = p.rose },
    ["@function.method.call"] = { fg = p.rose },
    ["@constructor"] = { fg = p.foam },
    ["@constructor.lua"] = { fg = p.subtle },
    ["@operator"] = { fg = p.subtle },
    ["@keyword"] = { fg = p.leaf },
    ["@keyword.coroutine"] = { fg = p.leaf },
    ["@keyword.function"] = { fg = p.leaf },
    ["@keyword.operator"] = { fg = p.leaf },
    ["@keyword.import"] = { fg = p.leaf },
    ["@keyword.type"] = { fg = p.leaf },
    ["@keyword.modifier"] = { fg = p.leaf },
    ["@keyword.repeat"] = { fg = p.leaf },
    ["@keyword.return"] = { fg = p.leaf },
    ["@keyword.debug"] = { fg = p.rose },
    ["@keyword.exception"] = { fg = p.leaf },
    ["@keyword.conditional"] = { fg = p.leaf },
    ["@keyword.conditional.ternary"] = { fg = p.subtle },
    ["@keyword.directive"] = { fg = p.iris },
    ["@keyword.directive.define"] = { fg = p.iris },
    ["@punctuation.delimiter"] = { fg = p.subtle },
    ["@punctuation.bracket"] = { fg = p.subtle },
    ["@punctuation.special"] = { fg = p.subtle },
    ["@comment"] = { link = "Comment" },
    ["@comment.documentation"] = { link = "Comment" },
    ["@comment.error"] = { fg = p.love, bold = true },
    ["@comment.warning"] = { fg = p.gold, bold = true },
    ["@comment.todo"] = { fg = p.leaf, bold = true },
    ["@comment.note"] = { fg = p.sky, bold = true },
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { fg = p.subtle, strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = p.leaf, bold = true },
    ["@markup.heading.1"] = { fg = p.leaf, bold = true },
    ["@markup.heading.2"] = { fg = p.foam, bold = true },
    ["@markup.heading.3"] = { fg = p.rose, bold = true },
    ["@markup.heading.4"] = { fg = p.gold, bold = true },
    ["@markup.heading.5"] = { fg = p.iris, bold = true },
    ["@markup.heading.6"] = { fg = p.subtle, bold = true },
    ["@markup.quote"] = { fg = p.subtle, italic = true },
    ["@markup.math"] = { fg = p.foam },
    ["@markup.link"] = { fg = p.sky },
    ["@markup.link.label"] = { fg = p.foam },
    ["@markup.link.url"] = { fg = p.sky, underline = true },
    ["@markup.raw"] = { fg = p.gold },
    ["@markup.raw.block"] = { fg = p.text },
    ["@markup.list"] = { fg = p.leaf },
    ["@markup.list.checked"] = { fg = p.leaf },
    ["@markup.list.unchecked"] = { fg = p.subtle },
    ["@diff.plus"] = { fg = p.leaf },
    ["@diff.minus"] = { fg = p.love },
    ["@diff.delta"] = { fg = p.sky },
    ["@tag"] = { fg = p.foam },
    ["@tag.builtin"] = { fg = p.foam },
    ["@tag.attribute"] = { fg = p.iris, italic = true },
    ["@tag.delimiter"] = { fg = p.subtle },

    -- ── LSP semantic tokens ───────────────────────────────────────────────
    ["@lsp.type.comment"] = {},
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.variable"] = {}, -- defer to Treesitter
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.interface"] = { link = "@type" },
    ["@lsp.type.typeParameter"] = { link = "@type" },
    ["@lsp.type.macro"] = { link = "@function.macro" },
    ["@lsp.type.decorator"] = { link = "@attribute" },
    ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.mod.deprecated"] = { strikethrough = true },

    -- ── Diagnostics ───────────────────────────────────────────────────────
    DiagnosticError = { fg = p.love },
    DiagnosticWarn = { fg = p.gold },
    DiagnosticInfo = { fg = p.sky },
    DiagnosticHint = { fg = p.leaf },
    DiagnosticOk = { fg = p.leaf },
    DiagnosticUnnecessary = { fg = p.faint },
    DiagnosticDeprecated = { strikethrough = true },
    DiagnosticUnderlineError = { sp = p.love, undercurl = true },
    DiagnosticUnderlineWarn = { sp = p.gold, undercurl = true },
    DiagnosticUnderlineInfo = { sp = p.sky, undercurl = true },
    DiagnosticUnderlineHint = { sp = p.leaf, undercurl = true },
    DiagnosticVirtualTextError = { fg = p.love, bg = p.error_bg },
    DiagnosticVirtualTextWarn = { fg = p.gold, bg = p.warn_bg },
    DiagnosticVirtualTextInfo = { fg = p.sky, bg = p.info_bg },
    DiagnosticVirtualTextHint = { fg = p.leaf, bg = p.hint_bg },
    LspReferenceText = { bg = p.hl_med },
    LspReferenceRead = { bg = p.hl_med },
    LspReferenceWrite = { bg = p.hl_med },
    LspInlayHint = { fg = p.muted, italic = true },
    LspCodeLens = { fg = p.faint },
    LspSignatureActiveParameter = { fg = p.iris, bold = true },
    LspInfoBorder = { link = "FloatBorder" },

    -- ── Plugins ───────────────────────────────────────────────────────────
    -- gitsigns
    GitSignsAdd = { fg = p.pine },
    GitSignsChange = { fg = p.sky },
    GitSignsDelete = { fg = p.love },
    GitSignsCurrentLineBlame = { fg = p.faint, italic = true },
    -- telescope
    TelescopeNormal = { fg = p.soft, bg = float_bg },
    TelescopeBorder = { fg = p.line, bg = float_bg },
    TelescopeTitle = { fg = p.leaf, bold = true },
    TelescopePromptNormal = { fg = p.text, bg = float_bg },
    TelescopePromptPrefix = { fg = p.pine },
    TelescopeSelection = { fg = p.text, bg = p.hl_med },
    TelescopeSelectionCaret = { fg = p.pine, bg = p.hl_med },
    TelescopeMatching = { fg = p.leaf, bold = true },
    -- fzf-lua / snacks picker
    FzfLuaBorder = { link = "FloatBorder" },
    FzfLuaTitle = { link = "FloatTitle" },
    SnacksPickerMatch = { fg = p.leaf, bold = true },
    SnacksPickerDir = { fg = p.faint },
    SnacksIndent = { fg = p.hl_med },
    SnacksIndentScope = { fg = p.faint },
    -- nvim-cmp / blink.cmp
    CmpItemAbbr = { fg = p.soft },
    CmpItemAbbrMatch = { fg = p.leaf, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = p.leaf },
    CmpItemAbbrDeprecated = { fg = p.faint, strikethrough = true },
    CmpItemMenu = { fg = p.faint },
    CmpItemKind = { fg = p.foam },
    CmpItemKindFunction = { fg = p.rose },
    CmpItemKindMethod = { fg = p.rose },
    CmpItemKindKeyword = { fg = p.leaf },
    CmpItemKindVariable = { fg = p.text },
    CmpItemKindConstant = { fg = p.gold },
    CmpItemKindSnippet = { fg = p.iris },
    CmpItemKindModule = { fg = p.subtle },
    BlinkCmpMenu = { link = "Pmenu" },
    BlinkCmpMenuBorder = { link = "FloatBorder" },
    BlinkCmpMenuSelection = { link = "PmenuSel" },
    BlinkCmpLabelMatch = { fg = p.leaf, bold = true },
    BlinkCmpKind = { fg = p.foam },
    BlinkCmpGhostText = { fg = p.faint },
    -- neo-tree / nvim-tree
    NeoTreeNormal = { fg = p.soft, bg = bg },
    NeoTreeNormalNC = { fg = p.soft, bg = bg },
    NeoTreeDirectoryName = { fg = p.text },
    NeoTreeDirectoryIcon = { fg = p.pine },
    NeoTreeRootName = { fg = p.leaf, bold = true },
    NeoTreeGitAdded = { fg = p.leaf },
    NeoTreeGitModified = { fg = p.sky },
    NeoTreeGitDeleted = { fg = p.love },
    NeoTreeGitUntracked = { fg = p.leaf },
    NeoTreeGitIgnored = { fg = p.faint },
    NeoTreeIndentMarker = { fg = p.hl_med },
    NvimTreeNormal = { fg = p.soft, bg = bg },
    NvimTreeFolderName = { fg = p.text },
    NvimTreeOpenedFolderName = { fg = p.text },
    NvimTreeFolderIcon = { fg = p.pine },
    NvimTreeRootFolder = { fg = p.leaf, bold = true },
    NvimTreeGitDirty = { fg = p.sky },
    NvimTreeGitNew = { fg = p.leaf },
    NvimTreeGitDeleted = { fg = p.love },
    NvimTreeIndentMarker = { fg = p.hl_med },
    -- indent-blankline / mini.indentscope
    IblIndent = { fg = p.hl_med },
    IblScope = { fg = p.faint },
    MiniIndentscopeSymbol = { fg = p.faint },
    -- which-key
    WhichKey = { fg = p.leaf },
    WhichKeyGroup = { fg = p.foam },
    WhichKeyDesc = { fg = p.text },
    WhichKeySeparator = { fg = p.faint },
    -- lazy.nvim / mason
    LazyH1 = { fg = p.base, bg = p.pine, bold = true },
    LazyButtonActive = { fg = p.base, bg = p.pine },
    LazySpecial = { fg = p.leaf },
    MasonHighlight = { fg = p.leaf },
    MasonHeader = { fg = p.base, bg = p.pine, bold = true },
    -- flash / leap
    FlashLabel = { fg = p.base, bg = p.love, bold = true },
    FlashMatch = { fg = p.foam },
    FlashBackdrop = { fg = p.faint },
    -- noice / notify
    NoiceCmdlinePopupBorder = { fg = p.pine },
    NoiceCmdlineIcon = { fg = p.pine },
    NotifyERRORBorder = { fg = p.love },
    NotifyWARNBorder = { fg = p.gold },
    NotifyINFOBorder = { fg = p.pine },
    NotifyERRORTitle = { fg = p.love },
    NotifyWARNTitle = { fg = p.gold },
    NotifyINFOTitle = { fg = p.leaf },
    -- render-markdown
    RenderMarkdownCode = { bg = p.surface },
    RenderMarkdownH1Bg = { fg = p.leaf, bg = p.hint_bg },
    RenderMarkdownH2Bg = { fg = p.foam, bg = p.info_bg },
    -- dap
    DapBreakpoint = { fg = p.love },
    DapStopped = { fg = p.gold },
    -- rainbow delimiters
    RainbowDelimiterRed = { fg = p.subtle },
    RainbowDelimiterYellow = { fg = p.gold },
    RainbowDelimiterBlue = { fg = p.sky },
    RainbowDelimiterOrange = { fg = p.rose },
    RainbowDelimiterGreen = { fg = p.leaf },
    RainbowDelimiterViolet = { fg = p.iris },
    RainbowDelimiterCyan = { fg = p.foam },
  }
end

--- The palette for a variant ("dark" or "light"), or for the active one.
function M.palette(variant)
  variant = variant or M.options.variant
  if variant ~= "dark" and variant ~= "light" then
    variant = vim.o.background == "light" and "light" or "dark"
  end
  return require("moss-rose.palettes." .. variant)
end

function M.load(variant)
  local p = M.palette(variant)
  local o = M.options

  if vim.g.colors_name then
    vim.cmd("highlight clear")
  end
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.o.termguicolors = true
  -- Set 'background' before naming the colorscheme, so Neovim does not reload it.
  if vim.o.background ~= p.variant then
    vim.o.background = p.variant
  end
  vim.g.colors_name = variant == "light" and "moss-rose-light" or "moss-rose"

  local hl = groups(p, o)
  local overrides = o.overrides
  if type(overrides) == "function" then
    overrides = overrides(p)
  end
  hl = vim.tbl_extend("force", hl, overrides or {})

  for group, spec in pairs(hl) do
    vim.api.nvim_set_hl(0, group, spec)
  end

  for i, color in ipairs(p.ansi) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end
end

return M
