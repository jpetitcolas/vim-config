return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        config = function()
            require("rose-pine").setup({
                variant = "moon",
            })
            vim.cmd("colorscheme rose-pine-moon")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "rose-pine",
                },
            })
        end,
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({
                options = {
                    diagnostics = "nvim_lsp",
                    offsets = {
                        { filetype = "neo-tree", text = "File Explorer", text_align = "center" },
                    },
                },
            })
            -- Keybindings
            local map = vim.keymap.set
            map("n", "<A-]>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
            map("n", "<A-[>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
            map("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "Go to buffer 1" })
            map("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "Go to buffer 2" })
            map("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "Go to buffer 3" })
            map("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "Go to buffer 4" })
            map("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "Go to buffer 5" })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup()
        end,
    },
}
