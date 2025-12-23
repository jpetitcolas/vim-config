return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("diffview").setup({})

        vim.keymap.set("n", "<A-d>", function()
            local lib = require("diffview.lib")
            local view = lib.get_current_view()
            if view then
                vim.cmd("DiffviewClose")
            else
                -- Hide terminals before showing diffview
                if _G.Terminal then _G.Terminal.hide() end
                if _G.ClaudeTerminal then _G.ClaudeTerminal.hide() end
                vim.cmd("DiffviewOpen")
                -- Pre-start Claude in background
                vim.defer_fn(function()
                    if _G.ClaudeTerminal then
                        _G.ClaudeTerminal.prestart()
                    end
                end, 500)
            end
        end, { desc = "Switch to diff view" })
    end,
}
