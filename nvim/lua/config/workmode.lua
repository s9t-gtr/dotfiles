-- 作業モード（~/dotfiles/bin/workmode）に合わせて nvim のアクセント色を連動させる。
-- colorscheme（gruber-darker）は変えず、CursorLineNr/StatusLine/WinSeparator のみ
-- 上書きする。色は tmux/modes/*.conf と揃えている。

local ACCENTS = {
  coding = "#96a6c8",
  review = "#ffdd33",
  research = "#73c936",
  writing = "#9e95c7",
  ["break"] = "#cc8c3c",
}

local STATE_FILE = vim.fn.expand("~/.config/workmode")

local function read_mode()
  local f = io.open(STATE_FILE, "r")
  if not f then
    return "coding"
  end
  local mode = f:read("l")
  f:close()
  return (mode and ACCENTS[mode]) and mode or "coding"
end

local function apply_accent()
  local accent = ACCENTS[read_mode()]
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = accent, bold = true })
  vim.api.nvim_set_hl(0, "StatusLine", { fg = accent })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = accent })
end

local M = {}

function M.setup()
  local group = vim.api.nvim_create_augroup("WorkMode", { clear = true })

  -- 起動時・他プラグインが colorscheme を再適用した時に追従
  vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
    group = group,
    callback = apply_accent,
  })

  -- `workmode` スクリプトからの `pkill -USR1 nvim` を受けて即時反映
  vim.api.nvim_create_autocmd("Signal", {
    group = group,
    pattern = "SIGUSR1",
    callback = apply_accent,
  })
end

return M
