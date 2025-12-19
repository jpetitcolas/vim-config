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
          vim.keymap.set("n", "<leader>e", function()
            local original_buf = args.buf
            local original_pos = vim.api.nvim_win_get_cursor(0)

            local float_bufnr, float_winnr = vim.diagnostic.open_float({ focus = true, focusable = true })
            if not float_bufnr then return end

            -- Explicitly focus the float window
            vim.api.nvim_set_current_win(float_winnr)

            -- Press 'f' in the float to fix error with Claude
            vim.keymap.set("n", "f", function()
              -- Get diagnostics from the original buffer at cursor position
              local diagnostics = vim.diagnostic.get(original_buf, { lnum = original_pos[1] - 1 })
              local col = original_pos[2]
              local at_cursor = vim.tbl_filter(function(d)
                return col >= d.col and col <= d.end_col
              end, diagnostics)

              if #at_cursor == 0 then at_cursor = diagnostics end
              if #at_cursor == 0 then return end

              local filename = vim.api.nvim_buf_get_name(original_buf)
              local line = original_pos[1]
              local messages = vim.tbl_map(function(d) return d.message end, at_cursor)
              local error_text = table.concat(messages, "\n")

              -- Close the float
              vim.api.nvim_win_close(float_winnr, true)

              if not _G.ClaudeTerminal then
                vim.notify("Claude terminal not loaded", vim.log.levels.ERROR)
                return
              end

              local prompt = string.format("Fix this error in %s:%d\n\n%s", filename, line, error_text)
              _G.ClaudeTerminal.send_when_ready(prompt, {
                on_success = function()
                  vim.notify("Sent to Claude", vim.log.levels.INFO)
                end,
              })
            end, { buffer = float_bufnr })
          end, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>rename", vim.lsp.buf.rename, opts)

          -- Copy diagnostic under cursor to clipboard for Claude
          vim.keymap.set("n", "<leader>fix", function()
            local pos = vim.api.nvim_win_get_cursor(0)
            local diagnostics = vim.diagnostic.get(0, { lnum = pos[1] - 1 })

            -- Filter to diagnostics that span the cursor column
            local col = pos[2]
            local at_cursor = vim.tbl_filter(function(d)
              return col >= d.col and col <= d.end_col
            end, diagnostics)

            if #at_cursor == 0 then return end

            local filename = vim.api.nvim_buf_get_name(0)
            local line = pos[1]
            local messages = vim.tbl_map(function(d) return d.message end, at_cursor)
            local prompt = string.format("Fix this error in %s:%d\n\n%s", filename, line, table.concat(messages, "\n"))
            vim.fn.setreg("+", prompt)
            print("Copied error to clipboard")
          end, opts)
        end,
      })
    end,
  },
}
