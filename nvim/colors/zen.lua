vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "zen"
vim.o.background = "light"

local hi = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Palette (zen — 静寂。白磁の背景に水色/青系のアクセント。日本の伝統色ベース)
local p = {
  -- Backgrounds
  bg        = "#f8fafb", -- 白磁: nearly white, faint coolness
  bg_alt    = "#eef4f7", -- subtle cool gray
  bg_float  = "#ffffff", -- clean white for floats
  bg_visual = "#cfe7f0", -- 水色 selection
  bg_search = "#b8dfec", -- 白群 search
  bg_line   = "#f0f6f8", -- barely tinted cursorline

  -- Foregrounds
  fg        = "#3f5666", -- 藍鼠: ink with a hint of indigo
  fg_dim    = "#6c8291", -- muted blue-gray
  fg_comment= "#7d94a2", -- soft blue-gray for comments (2.4:1は薄すぎたので3.2:1に)
  fg_line_nr= "#c3d2da", -- line numbers

  -- Accents (青系)
  asagi     = "#3a97ac", -- 浅葱: primary accent
  asagi_dim = "#2f7f92", -- darker asagi (keywords)
  hanada    = "#4a7fa5", -- 縹: functions
  byakugun  = "#55b0c4", -- 白群: bright cyan
  mizu      = "#a5d3e2", -- 水色: light accent

  -- Supporting hues (muted, quiet)
  suou      = "#b25d5d", -- 蘇芳: errors
  seiji     = "#5f9982", -- 青磁: strings
  karashi   = "#9c823a", -- 芥子: types
  fuji      = "#8677ad", -- 藤: preproc

  -- UI
  border    = "#dbe6ec", -- subtle cool border
  none      = "NONE",
}

-- Editor
hi("Normal",       { fg = p.fg, bg = p.bg })
hi("NormalFloat",  { fg = p.fg, bg = p.bg_float })
hi("FloatBorder",  { fg = p.border, bg = p.bg_float })
hi("Cursor",       { fg = p.bg, bg = p.asagi })
hi("CursorLine",   { bg = p.bg_line })
hi("CursorColumn", { bg = p.bg_line })
hi("ColorColumn",  { bg = p.bg_alt })
hi("LineNr",       { fg = p.fg_line_nr })
hi("CursorLineNr", { fg = p.asagi, bold = true })
hi("SignColumn",   { fg = p.fg_line_nr, bg = p.bg })
hi("VertSplit",    { fg = p.border })
hi("WinSeparator", { fg = p.border })
hi("Folded",       { fg = p.fg_comment, bg = p.bg_alt })
hi("FoldColumn",   { fg = p.fg_line_nr, bg = p.bg })
hi("NonText",      { fg = p.border })
hi("SpecialKey",   { fg = p.border })
hi("Conceal",      { fg = p.fg_dim })
hi("EndOfBuffer",  { fg = p.bg_alt })
hi("MatchParen",   { fg = p.asagi, bg = p.bg_visual, bold = true })

-- Search & Visual
hi("Visual",       { bg = p.bg_visual })
hi("VisualNOS",    { bg = p.bg_visual })
hi("Search",       { fg = p.fg, bg = p.bg_search })
hi("IncSearch",    { fg = p.bg, bg = p.asagi })
hi("CurSearch",    { fg = p.bg, bg = p.asagi })
hi("Substitute",   { fg = p.bg, bg = p.asagi })

-- Statusline & Tabline
hi("StatusLine",   { fg = p.fg, bg = p.bg_alt })
hi("StatusLineNC", { fg = p.fg_comment, bg = p.bg_alt })
hi("TabLine",      { fg = p.fg_dim, bg = p.bg_alt })
hi("TabLineFill",  { bg = p.bg_alt })
hi("TabLineSel",   { fg = p.asagi, bg = p.bg, bold = true })
hi("WinBar",       { fg = p.fg_dim, bg = p.bg })
hi("WinBarNC",     { fg = p.fg_comment, bg = p.bg })

-- Popup Menu
hi("Pmenu",        { fg = p.fg, bg = p.bg_float })
hi("PmenuSel",     { fg = p.bg, bg = p.asagi })
hi("PmenuSbar",    { bg = p.bg_alt })
hi("PmenuThumb",   { bg = p.asagi_dim })

-- Messages
hi("ModeMsg",      { fg = p.asagi, bold = true })
hi("MsgArea",      { fg = p.fg })
hi("MoreMsg",      { fg = p.seiji })
hi("Question",     { fg = p.seiji })
hi("WarningMsg",   { fg = p.karashi })
hi("ErrorMsg",     { fg = p.suou, bold = true })

-- Diagnostics
hi("DiagnosticError", { fg = p.suou })
hi("DiagnosticWarn",  { fg = p.karashi })
hi("DiagnosticInfo",  { fg = p.hanada })
hi("DiagnosticHint",  { fg = p.seiji })
hi("DiagnosticUnderlineError", { sp = p.suou, undercurl = true })
hi("DiagnosticUnderlineWarn",  { sp = p.karashi, undercurl = true })
hi("DiagnosticUnderlineInfo",  { sp = p.hanada, undercurl = true })
hi("DiagnosticUnderlineHint",  { sp = p.seiji, undercurl = true })

-- Diff
hi("DiffAdd",    { bg = "#ddeee4" })
hi("DiffChange", { bg = "#e5edd8" })
hi("DiffDelete", { fg = p.suou, bg = "#f0dede" })
hi("DiffText",   { bg = "#cfe3c8" })

-- Spelling
hi("SpellBad",  { sp = p.suou, undercurl = true })
hi("SpellCap",  { sp = p.hanada, undercurl = true })
hi("SpellRare", { sp = p.fuji, undercurl = true })
hi("SpellLocal",{ sp = p.seiji, undercurl = true })

-- Syntax (base Vim groups)
hi("Comment",     { fg = p.fg_comment, italic = true })
hi("Constant",    { fg = p.asagi })
hi("String",      { fg = p.seiji })
hi("Character",   { fg = p.seiji })
hi("Number",      { fg = p.asagi })
hi("Boolean",     { fg = p.asagi })
hi("Float",       { fg = p.asagi })
hi("Identifier",  { fg = p.fg })
hi("Function",    { fg = p.hanada })
hi("Statement",   { fg = p.asagi_dim, bold = true })
hi("Conditional", { fg = p.asagi_dim, bold = true })
hi("Repeat",      { fg = p.asagi_dim, bold = true })
hi("Label",       { fg = p.asagi_dim })
hi("Operator",    { fg = p.fg_dim })
hi("Keyword",     { fg = p.asagi_dim, bold = true })
hi("Exception",   { fg = p.suou })
hi("PreProc",     { fg = p.fuji })
hi("Include",     { fg = p.fuji })
hi("Define",      { fg = p.fuji })
hi("Macro",       { fg = p.fuji })
hi("PreCondit",   { fg = p.fuji })
hi("Type",        { fg = p.karashi })
hi("StorageClass",{ fg = p.karashi })
hi("Structure",   { fg = p.karashi })
hi("Typedef",     { fg = p.karashi })
hi("Special",     { fg = p.byakugun })
hi("SpecialChar", { fg = p.byakugun })
hi("Tag",         { fg = p.asagi })
hi("Delimiter",   { fg = p.fg_dim })
hi("Debug",       { fg = p.suou })
hi("Underlined",  { underline = true })
hi("Ignore",      { fg = p.fg_comment })
hi("Error",       { fg = p.suou, bold = true })
hi("Todo",        { fg = p.asagi, bg = p.bg_alt, bold = true })

-- Treesitter
hi("@variable",          { fg = p.fg })
hi("@variable.builtin",  { fg = p.byakugun, italic = true })
hi("@variable.parameter",{ fg = p.fg_dim })
hi("@constant",          { fg = p.asagi })
hi("@constant.builtin",  { fg = p.asagi, italic = true })
hi("@module",            { fg = p.fuji })
hi("@string",            { fg = p.seiji })
hi("@string.escape",     { fg = p.byakugun })
hi("@string.regex",      { fg = p.byakugun })
hi("@character",         { fg = p.seiji })
hi("@number",            { fg = p.asagi })
hi("@boolean",           { fg = p.asagi, italic = true })
hi("@float",             { fg = p.asagi })
hi("@function",          { fg = p.hanada })
hi("@function.builtin",  { fg = p.hanada, italic = true })
hi("@function.macro",    { fg = p.fuji })
hi("@method",            { fg = p.hanada })
hi("@constructor",       { fg = p.karashi })
hi("@keyword",           { fg = p.asagi_dim, bold = true })
hi("@keyword.function",  { fg = p.asagi_dim })
hi("@keyword.return",    { fg = p.asagi_dim, bold = true })
hi("@keyword.operator",  { fg = p.fg_dim })
hi("@operator",          { fg = p.fg_dim })
hi("@punctuation",       { fg = p.fg_dim })
hi("@punctuation.bracket",   { fg = p.fg_dim })
hi("@punctuation.delimiter", { fg = p.fg_dim })
hi("@type",              { fg = p.karashi })
hi("@type.builtin",      { fg = p.karashi, italic = true })
hi("@property",          { fg = p.fg })
hi("@field",             { fg = p.fg })
hi("@parameter",         { fg = p.fg_dim })
hi("@attribute",         { fg = p.fuji })
hi("@tag",               { fg = p.asagi })
hi("@tag.attribute",     { fg = p.karashi })
hi("@tag.delimiter",     { fg = p.fg_dim })
hi("@text.title",        { fg = p.asagi, bold = true })
hi("@text.strong",       { bold = true })
hi("@text.emphasis",     { italic = true })
hi("@text.uri",          { fg = p.hanada, underline = true })
hi("@text.literal",      { fg = p.seiji })
hi("@comment",           { fg = p.fg_comment, italic = true })
hi("@markup.strikethrough", { strikethrough = true })

-- LSP Semantic Tokens
hi("@lsp.type.function",  { fg = p.hanada })
hi("@lsp.type.method",    { fg = p.hanada })
hi("@lsp.type.parameter", { fg = p.fg_dim })
hi("@lsp.type.variable",  { fg = p.fg })
hi("@lsp.type.property",  { fg = p.fg })
hi("@lsp.type.type",      { fg = p.karashi })
hi("@lsp.type.namespace", { fg = p.fuji })
hi("@lsp.type.enum",      { fg = p.karashi })
hi("@lsp.type.interface", { fg = p.karashi })
hi("@lsp.type.struct",    { fg = p.karashi })
hi("@lsp.type.decorator", { fg = p.fuji })
hi("@lsp.mod.deprecated", { strikethrough = true })

-- GitSigns
hi("GitSignsAdd",    { fg = p.seiji })
hi("GitSignsChange", { fg = p.karashi })
hi("GitSignsDelete", { fg = p.suou })

-- Telescope
hi("TelescopeNormal",       { fg = p.fg, bg = p.bg_float })
hi("TelescopeBorder",       { fg = p.mizu, bg = p.bg_float })
hi("TelescopePromptNormal", { fg = p.fg, bg = p.bg_alt })
hi("TelescopePromptBorder", { fg = p.asagi, bg = p.bg_alt })
hi("TelescopePromptTitle",  { fg = p.bg, bg = p.asagi, bold = true })
hi("TelescopePreviewTitle", { fg = p.bg, bg = p.hanada, bold = true })
hi("TelescopeResultsTitle", { fg = p.bg, bg = p.seiji, bold = true })
hi("TelescopeSelection",    { bg = p.bg_visual })
hi("TelescopeMatching",     { fg = p.asagi, bold = true })

-- Lazy.nvim
hi("LazyButton",        { fg = p.fg, bg = p.bg_alt })
hi("LazyButtonActive",  { fg = p.bg, bg = p.asagi })
hi("LazyH1",            { fg = p.bg, bg = p.asagi, bold = true })
hi("LazySpecial",       { fg = p.asagi })

-- Title & Directory
hi("Title",     { fg = p.asagi, bold = true })
hi("Directory", { fg = p.hanada })

-- Terminal colors (ghostty/themes/zen と同じパレット)
vim.g.terminal_color_0  = "#46606f"
vim.g.terminal_color_1  = "#b25d5d"
vim.g.terminal_color_2  = "#5f9982"
vim.g.terminal_color_3  = "#9c823a"
vim.g.terminal_color_4  = "#4a7fa5"
vim.g.terminal_color_5  = "#8677ad"
vim.g.terminal_color_6  = "#3a97ac"
vim.g.terminal_color_7  = "#c2d4dc"
vim.g.terminal_color_8  = "#8fa7b3"
vim.g.terminal_color_9  = "#c47272"
vim.g.terminal_color_10 = "#6fae94"
vim.g.terminal_color_11 = "#b09a4d"
vim.g.terminal_color_12 = "#5b93c4"
vim.g.terminal_color_13 = "#9b8cc4"
vim.g.terminal_color_14 = "#55b0c4"
vim.g.terminal_color_15 = "#eef4f7"
