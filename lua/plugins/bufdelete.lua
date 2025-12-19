return {
    "famiu/bufdelete.nvim",
    config = function()
        vim.keymap.set("n", "<A-w>", "<cmd>Bdelete<cr>", { desc = "Close buffer" })
    end,
}
