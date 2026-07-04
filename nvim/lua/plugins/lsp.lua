return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  init = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buf = args.buf
        vim.schedule(function()
          -- Delete default gr* mappings to make "gr" instant
          pcall(vim.keymap.del, "n", "grr", { buffer = buf })
          pcall(vim.keymap.del, "n", "grn", { buffer = buf })
          pcall(vim.keymap.del, "n", "gra", { buffer = buf })
          pcall(vim.keymap.del, "n", "gri", { buffer = buf })

          vim.keymap.set("n", "gd", function() require("telescope.builtin").lsp_definitions() end, { buffer = buf, desc = "Go to Definition" })
          vim.keymap.set("n", "gr", function() require("telescope.builtin").lsp_references() end, { buffer = buf, desc = "References" })
          vim.keymap.set("n", "<leader>ds", function() require("telescope.builtin").lsp_document_symbols() end, { buffer = buf, desc = "Document Symbols" })
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "Code Action" })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buf, desc = "Rename" })
        end)
      end,
    })
  end,
  config = function()
    -- blink.cmp の補完 capability に nvim-ufo 用の foldingRange をマージして全クライアントへ付与
    local capabilities = require("blink.cmp").get_lsp_capabilities({
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    })
    vim.lsp.config("*", { capabilities = capabilities })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME },
          },
        },
      },
    })

    vim.lsp.enable({ "clangd", "lua_ls", "intelephense", "gopls" })

    vim.diagnostic.config({
      -- 行末のインライン表示は長い行で右に見切れるため無効化し、
      -- カーソル行の診断はコード下に折り返し表示（virtual_lines）する
      virtual_text = false,
      virtual_lines = { current_line = true },
      severity_sort = true,
      float = {
        border = "rounded",
        source = "if_many",
      },
    })

    -- カーソル行の診断を枠付きフロートで全文表示（折り返し・スクロール可）
    vim.keymap.set("n", "<leader>l", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
  end,
}
