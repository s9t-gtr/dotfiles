return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  opts = {},
  keys = {
    { "<leader>z", function() require("zen-mode").toggle() end, desc = "Toggle Zen Mode" },
  },
}
