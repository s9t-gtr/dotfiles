return {
  "neovim/nvim-lspconfig",
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

    vim.lsp.enable({ "clangd", "lua_ls", "intelephense" })
  end,
}
