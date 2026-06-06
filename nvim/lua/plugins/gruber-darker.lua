return {
  "blazkowolf/gruber-darker.nvim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("gruber-darker")
    vim.api.nvim_set_hl(0, "@markup.strikethrough", { strikethrough = true })

    for _, group in ipairs({
      "Normal",
      "NormalNC",
      "NormalFloat",
      "FloatBorder",
      "EndOfBuffer",
      "SignColumn",
      "LineNr",
    }) do
      vim.api.nvim_set_hl(0, group, { bg = "NONE" })
    end
  end,
}
