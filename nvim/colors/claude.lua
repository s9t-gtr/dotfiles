vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "claude"
vim.o.background = "light"

local hi = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Palette (extracted from Claude's design language)
local p = {
  -- Backgrounds
  bg        = "#FDFCFB", -- nearly white, faint warmth
  bg_alt    = "#F5F1ED", -- subtle warm gray
  bg_float  = "#FFFFFF", -- clean white for floats
  bg_visual = "#F0DDD0", -- warm peach selection
  bg_search = "#F5D5B8", -- warm peach search
  bg_line   = "#F8F5F2", -- barely tinted cursorline

  -- Foregrounds
  fg        = "#3D3530", -- warm dark brown
  fg_dim    = "#7A6E64", -- muted brown
  fg_comment= "#A89888", -- soft brown for comments
  fg_line_nr= "#CCC4BA", -- line numbers

  -- Accents
  coral     = "#D4845A", -- primary coral/terracotta
  coral_dim = "#C07A52", -- darker coral
  coral_bright = "#E09060", -- brighter coral
  rust      = "#B5624A", -- rust red (errors)
  terracotta= "#C4704C", -- warm terracotta

  -- Syntax colors (warm, muted palette)
  ochre     = "#B88A40", -- yellow/gold (strings)
  olive     = "#7A8A50", -- muted green
  sage      = "#6A8868", -- sage green (strings alt)
  slate     = "#687888", -- muted blue
  dusty_blue= "#5A7A90", -- dusty blue (functions)
  plum      = "#9A6878", -- muted plum/mauve
  sienna    = "#A86848", -- warm sienna

  -- UI
  border    = "#E8E0D8", -- subtle warm border
  none      = "NONE",
}

-- Editor
hi("Normal",       { fg = p.fg, bg = p.bg })
hi("NormalFloat",  { fg = p.fg, bg = p.bg_float })
hi("FloatBorder",  { fg = p.border, bg = p.bg_float })
hi("Cursor",       { fg = p.bg, bg = p.coral })
hi("CursorLine",   { bg = p.bg_line })
hi("CursorColumn", { bg = p.bg_line })
hi("ColorColumn",  { bg = p.bg_alt })
hi("LineNr",       { fg = p.fg_line_nr })
hi("CursorLineNr", { fg = p.coral, bold = true })
hi("SignColumn",   { fg = p.fg_line_nr, bg = p.bg })
hi("VertSplit",    { fg = p.border })
hi("WinSeparator", { fg = p.border })
hi("Folded",       { fg = p.fg_comment, bg = p.bg_alt })
hi("FoldColumn",   { fg = p.fg_line_nr, bg = p.bg })
hi("NonText",      { fg = p.border })
hi("SpecialKey",   { fg = p.border })
hi("Conceal",      { fg = p.fg_dim })
hi("EndOfBuffer",  { fg = p.bg_alt })
hi("MatchParen",   { fg = p.coral, bg = p.bg_visual, bold = true })

-- Search & Visual
hi("Visual",       { bg = p.bg_visual })
hi("VisualNOS",    { bg = p.bg_visual })
hi("Search",       { fg = p.fg, bg = p.bg_search })
hi("IncSearch",    { fg = p.bg, bg = p.coral })
hi("CurSearch",    { fg = p.bg, bg = p.coral })
hi("Substitute",   { fg = p.bg, bg = p.coral })

-- Statusline & Tabline
hi("StatusLine",   { fg = p.fg, bg = p.bg_alt })
hi("StatusLineNC", { fg = p.fg_comment, bg = p.bg_alt })
hi("TabLine",      { fg = p.fg_dim, bg = p.bg_alt })
hi("TabLineFill",  { bg = p.bg_alt })
hi("TabLineSel",   { fg = p.coral, bg = p.bg, bold = true })
hi("WinBar",       { fg = p.fg_dim, bg = p.bg })
hi("WinBarNC",     { fg = p.fg_comment, bg = p.bg })

-- Popup Menu
hi("Pmenu",        { fg = p.fg, bg = p.bg_float })
hi("PmenuSel",     { fg = p.bg, bg = p.coral })
hi("PmenuSbar",    { bg = p.bg_alt })
hi("PmenuThumb",   { bg = p.coral_dim })

-- Messages
hi("ModeMsg",      { fg = p.coral, bold = true })
hi("MsgArea",      { fg = p.fg })
hi("MoreMsg",      { fg = p.sage })
hi("Question",     { fg = p.sage })
hi("WarningMsg",   { fg = p.ochre })
hi("ErrorMsg",     { fg = p.rust, bold = true })

-- Diagnostics
hi("DiagnosticError", { fg = p.rust })
hi("DiagnosticWarn",  { fg = p.ochre })
hi("DiagnosticInfo",  { fg = p.dusty_blue })
hi("DiagnosticHint",  { fg = p.sage })
hi("DiagnosticUnderlineError", { sp = p.rust, undercurl = true })
hi("DiagnosticUnderlineWarn",  { sp = p.ochre, undercurl = true })
hi("DiagnosticUnderlineInfo",  { sp = p.dusty_blue, undercurl = true })
hi("DiagnosticUnderlineHint",  { sp = p.sage, undercurl = true })

-- Diff
hi("DiffAdd",    { bg = "#DDE8D8" })
hi("DiffChange", { bg = "#E8E0D0" })
hi("DiffDelete", { fg = p.rust, bg = "#ECDCD8" })
hi("DiffText",   { bg = "#D8D0C0" })

-- Spelling
hi("SpellBad",  { sp = p.rust, undercurl = true })
hi("SpellCap",  { sp = p.dusty_blue, undercurl = true })
hi("SpellRare", { sp = p.plum, undercurl = true })
hi("SpellLocal",{ sp = p.sage, undercurl = true })

-- Syntax (base Vim groups)
hi("Comment",     { fg = p.fg_comment, italic = true })
hi("Constant",    { fg = p.coral })
hi("String",      { fg = p.sage })
hi("Character",   { fg = p.sage })
hi("Number",      { fg = p.coral })
hi("Boolean",     { fg = p.coral })
hi("Float",       { fg = p.coral })
hi("Identifier",  { fg = p.fg })
hi("Function",    { fg = p.dusty_blue })
hi("Statement",   { fg = p.coral_dim, bold = true })
hi("Conditional", { fg = p.coral_dim, bold = true })
hi("Repeat",      { fg = p.coral_dim, bold = true })
hi("Label",       { fg = p.coral_dim })
hi("Operator",    { fg = p.fg_dim })
hi("Keyword",     { fg = p.terracotta, bold = true })
hi("Exception",   { fg = p.rust })
hi("PreProc",     { fg = p.plum })
hi("Include",     { fg = p.plum })
hi("Define",      { fg = p.plum })
hi("Macro",       { fg = p.plum })
hi("PreCondit",   { fg = p.plum })
hi("Type",        { fg = p.ochre })
hi("StorageClass",{ fg = p.ochre })
hi("Structure",   { fg = p.ochre })
hi("Typedef",     { fg = p.ochre })
hi("Special",     { fg = p.sienna })
hi("SpecialChar", { fg = p.sienna })
hi("Tag",         { fg = p.coral })
hi("Delimiter",   { fg = p.fg_dim })
hi("Debug",       { fg = p.rust })
hi("Underlined",  { underline = true })
hi("Ignore",      { fg = p.fg_comment })
hi("Error",       { fg = p.rust, bold = true })
hi("Todo",        { fg = p.coral, bg = p.bg_alt, bold = true })

-- Treesitter
hi("@variable",          { fg = p.fg })
hi("@variable.builtin",  { fg = p.sienna, italic = true })
hi("@variable.parameter",{ fg = p.fg_dim })
hi("@constant",          { fg = p.coral })
hi("@constant.builtin",  { fg = p.coral, italic = true })
hi("@module",            { fg = p.plum })
hi("@string",            { fg = p.sage })
hi("@string.escape",     { fg = p.sienna })
hi("@string.regex",      { fg = p.sienna })
hi("@character",         { fg = p.sage })
hi("@number",            { fg = p.coral })
hi("@boolean",           { fg = p.coral, italic = true })
hi("@float",             { fg = p.coral })
hi("@function",          { fg = p.dusty_blue })
hi("@function.builtin",  { fg = p.dusty_blue, italic = true })
hi("@function.macro",    { fg = p.plum })
hi("@method",            { fg = p.dusty_blue })
hi("@constructor",       { fg = p.ochre })
hi("@keyword",           { fg = p.terracotta, bold = true })
hi("@keyword.function",  { fg = p.terracotta })
hi("@keyword.return",    { fg = p.terracotta, bold = true })
hi("@keyword.operator",  { fg = p.fg_dim })
hi("@operator",          { fg = p.fg_dim })
hi("@punctuation",       { fg = p.fg_dim })
hi("@punctuation.bracket",   { fg = p.fg_dim })
hi("@punctuation.delimiter", { fg = p.fg_dim })
hi("@type",              { fg = p.ochre })
hi("@type.builtin",      { fg = p.ochre, italic = true })
hi("@property",          { fg = p.fg })
hi("@field",             { fg = p.fg })
hi("@parameter",         { fg = p.fg_dim })
hi("@attribute",         { fg = p.plum })
hi("@tag",               { fg = p.coral })
hi("@tag.attribute",     { fg = p.ochre })
hi("@tag.delimiter",     { fg = p.fg_dim })
hi("@text.title",        { fg = p.coral, bold = true })
hi("@text.strong",       { bold = true })
hi("@text.emphasis",     { italic = true })
hi("@text.uri",          { fg = p.dusty_blue, underline = true })
hi("@text.literal",      { fg = p.sage })
hi("@comment",           { fg = p.fg_comment, italic = true })

-- LSP Semantic Tokens
hi("@lsp.type.function",  { fg = p.dusty_blue })
hi("@lsp.type.method",    { fg = p.dusty_blue })
hi("@lsp.type.parameter", { fg = p.fg_dim })
hi("@lsp.type.variable",  { fg = p.fg })
hi("@lsp.type.property",  { fg = p.fg })
hi("@lsp.type.type",      { fg = p.ochre })
hi("@lsp.type.namespace", { fg = p.plum })
hi("@lsp.type.enum",      { fg = p.ochre })
hi("@lsp.type.interface", { fg = p.ochre })
hi("@lsp.type.struct",    { fg = p.ochre })
hi("@lsp.type.decorator", { fg = p.plum })
hi("@lsp.mod.deprecated", { strikethrough = true })

-- GitSigns
hi("GitSignsAdd",    { fg = p.olive })
hi("GitSignsChange", { fg = p.ochre })
hi("GitSignsDelete", { fg = p.rust })

-- Telescope
hi("TelescopeNormal",       { fg = p.fg, bg = p.bg_float })
hi("TelescopeBorder",       { fg = p.coral_dim, bg = p.bg_float })
hi("TelescopePromptNormal", { fg = p.fg, bg = p.bg_alt })
hi("TelescopePromptBorder", { fg = p.coral, bg = p.bg_alt })
hi("TelescopePromptTitle",  { fg = p.bg, bg = p.coral, bold = true })
hi("TelescopePreviewTitle", { fg = p.bg, bg = p.dusty_blue, bold = true })
hi("TelescopeResultsTitle", { fg = p.bg, bg = p.sage, bold = true })
hi("TelescopeSelection",   { bg = p.bg_visual })
hi("TelescopeMatching",     { fg = p.coral, bold = true })

-- Lazy.nvim
hi("LazyButton",       { fg = p.fg, bg = p.bg_alt })
hi("LazyButtonActive",  { fg = p.bg, bg = p.coral })
hi("LazyH1",           { fg = p.bg, bg = p.coral, bold = true })
hi("LazySpecial",      { fg = p.coral })

-- Title & Directory
hi("Title",     { fg = p.coral, bold = true })
hi("Directory", { fg = p.dusty_blue })

-- Terminal colors
vim.g.terminal_color_0  = p.fg          -- black
vim.g.terminal_color_1  = p.rust        -- red
vim.g.terminal_color_2  = p.olive       -- green
vim.g.terminal_color_3  = p.ochre       -- yellow
vim.g.terminal_color_4  = p.dusty_blue  -- blue
vim.g.terminal_color_5  = p.plum        -- magenta
vim.g.terminal_color_6  = p.sage        -- cyan
vim.g.terminal_color_7  = p.bg_alt      -- white
vim.g.terminal_color_8  = p.fg_dim      -- bright black
vim.g.terminal_color_9  = p.coral       -- bright red
vim.g.terminal_color_10 = p.sage        -- bright green
vim.g.terminal_color_11 = p.coral_bright-- bright yellow
vim.g.terminal_color_12 = p.slate       -- bright blue
vim.g.terminal_color_13 = p.terracotta  -- bright magenta
vim.g.terminal_color_14 = p.olive       -- bright cyan
vim.g.terminal_color_15 = p.bg          -- bright white
