return {
  "kepano/flexoki-neovim",
  name = "flexoki",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("flexoki-light")
    vim.api.nvim_set_hl(0, "@markup.strikethrough", { strikethrough = true })

    -- LineNr 本来の前景色(dim グレー)を保持しておく
    -- ※ nvim_set_hl はハイライト全体を置き換えるため、bg だけ渡すと fg が消え
    --   行番号がコードと同じ色になってしまう
    local linenr_fg = vim.api.nvim_get_hl(0, { name = "LineNr", link = false }).fg

    for _, group in ipairs({
      "Normal",
      "NormalNC",
      "NormalFloat",
      "FloatBorder",
      "EndOfBuffer",
      "SignColumn",
    }) do
      vim.api.nvim_set_hl(0, group, { bg = "NONE" })
    end

    -- 背景のみ透過し、Ghostty 側の紙色(#fffcf0)を活かす。dim な前景色は
    -- 維持してコードと区別できるようにする
    vim.api.nvim_set_hl(0, "LineNr", { fg = linenr_fg, bg = "NONE" })
  end,
}
