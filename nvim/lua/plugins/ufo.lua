return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    -- ufo は foldmethod を手動に切り替えるため、大きい値を設定して
    -- 起動時に折りたたみが閉じないようにする
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  opts = {
    -- LSP の foldingRange を優先し、未対応バッファは treesitter でフォールバック
    -- (provider_selector は {main, fallback} の2つまでしか返せない)
    provider_selector = function(_, _, _)
      return { "lsp", "treesitter" }
    end,
  },
  config = function(_, opts)
    require("ufo").setup(opts)

    -- zR/zM は foldlevel を変更するが、ufo の API は foldlevel を保持したまま
    -- 全展開/全折りたたみを行う
    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
  end,
}
