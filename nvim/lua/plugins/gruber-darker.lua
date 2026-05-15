return {
  "blazkowolf/gruber-darker.nvim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("gruber-darker")
    vim.api.nvim_set_hl(0, "@markup.strikethrough", { strikethrough = true })
  end,
}
