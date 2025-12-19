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
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
        })
        vim.keymap.set("n", "<A-e>", function()
            -- Check if we're in diffview by looking at buffer/filetype
            local ft = vim.bo.filetype
            local bufname = vim.fn.bufname()
            local in_diffview = ft:match("^Diffview") or bufname:match("^diffview://")

            -- Also check via diffview lib
            if not in_diffview then
                local ok, lib = pcall(require, "diffview.lib")
                if ok and lib.get_current_view() then
                    in_diffview = true
                end
            end

            if in_diffview then
                vim.cmd("DiffviewToggleFiles")
            else
                vim.cmd("Neotree toggle")
            end
        end, { desc = "Toggle file explorer / diffview files" })
    end,
}
