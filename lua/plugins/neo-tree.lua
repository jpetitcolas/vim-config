return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        -- Disable netrw
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("neo-tree").setup({
            close_if_last_window = true,
            hijack_netrw_behavior = "open_current",
            filesystem = {
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
            },
        })
        vim.keymap.set("n", "<A-e>", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })
    end,
}
