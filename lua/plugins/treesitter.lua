return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- Plugin doesn't support lazy loading
    build = ":TSUpdate",
    config = function()
      -- Install parsers (async, will download if missing)
      require("nvim-treesitter").install({
        "typescript",
        "tsx",
        "javascript",
        "json",
        "yaml",
        "html",
        "css",
        "lua",
        "markdown",
        "bash",
      })

      -- Enable treesitter highlighting for these filetypes
      local ts_filetypes = {
        "typescript", "typescriptreact",
        "javascript", "javascriptreact",
        "json", "yaml", "html", "css",
        "lua", "markdown", "bash", "sh",
      }

      local function enable_treesitter()
        local ft = vim.bo.filetype
        if vim.tbl_contains(ts_filetypes, ft) then
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
        pattern = "*",
        callback = enable_treesitter,
      })
    end,
  },
}
