return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<A-f>", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<A-g>", builtin.live_grep, { desc = "Grep in files" })
    end,
}
