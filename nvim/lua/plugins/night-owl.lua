return {
  "oxfist/night-owl.nvim",
  priority = 1000,
  config = function()
    -- 背景を透過して Ghostty 側の夜空(蛍テーマ)を活かす
    require("night-owl").setup({ transparent_background = true })
    vim.cmd.colorscheme("night-owl")
    vim.api.nvim_set_hl(0, "@markup.strikethrough", { strikethrough = true })
  end,
}
