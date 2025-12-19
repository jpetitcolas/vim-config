return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- TypeScript (uses project-local tsserver from node_modules)
      vim.lsp.config("ts_ls", {})

      -- ESLint (uses project-local eslint and respects .eslintrc)
      vim.lsp.config("eslint", {})

      -- Biome (uses project-local biome and respects biome.json)
      vim.lsp.config("biome", {})

      -- Enable all configured servers
      vim.lsp.enable({ "ts_ls", "eslint", "biome" })

      -- Diagnostics: signs only, no virtual text
      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      -- LSP keybindings on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>rename", vim.lsp.buf.rename, opts)
        end,
      })
    end,
  },
}
