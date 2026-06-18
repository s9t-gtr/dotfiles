return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    -- ufo は foldmethod を手動に切り替えるため、大きい値を設定して
    -- 起動時に折りたたみが閉じないようにする
    -- foldcolumn は gitsigns の差分サインと gutter が競合するため無効化
    -- (折りたたみは za/zR/zM で操作可能)
    vim.o.foldcolumn = "0"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  config = function()
    local ufo = require("ufo")

    -- LSP → treesitter → indent の3段フォールバック。
    -- provider_selector のテーブル形式は {main, fallback} の2つまでなので、
    -- 3段にするには UfoFallbackException を自前で catch する関数を返す。
    local function selector(bufnr)
      local function handleFallback(err, providerName)
        if type(err) == "string" and err:match("UfoFallbackException") then
          return ufo.getFolds(bufnr, providerName)
        end
        return require("promise").reject(err)
      end

      return ufo.getFolds(bufnr, "lsp")
        :catch(function(err)
          return handleFallback(err, "treesitter")
        end)
        :catch(function(err)
          return handleFallback(err, "indent")
        end)
    end

    ufo.setup({
      provider_selector = function(_, _, _)
        return selector
      end,
    })

    -- zR/zM は foldlevel を変更するが、ufo の API は foldlevel を保持したまま
    -- 全展開/全折りたたみを行う
    vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
  end,
}
