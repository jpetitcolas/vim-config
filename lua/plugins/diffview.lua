return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("diffview").setup({})

        local function get_base_ref()
            -- Try origin/main, origin/master
            local refs = { "origin/main", "origin/master" }
            for _, ref in ipairs(refs) do
                local ref_sha = vim.fn.system("git rev-parse --verify " .. ref .. " 2>/dev/null"):gsub("%s+", "")
                local head_sha = vim.fn.system("git rev-parse HEAD 2>/dev/null"):gsub("%s+", "")
                if vim.v.shell_error == 0 and ref_sha ~= "" and ref_sha ~= head_sha then
                    -- Remote exists and differs from HEAD - show commits between them
                    return ref .. "...HEAD"
                end
            end
            -- No remote or same as HEAD - show uncommitted working directory changes
            return nil
        end

        vim.keymap.set("n", "<A-d>", function()
            local lib = require("diffview.lib")
            local view = lib.get_current_view()
            if view then
                vim.cmd("DiffviewClose")
            else
                local ref = get_base_ref()
                if ref then
                    vim.cmd("DiffviewOpen " .. ref)
                else
                    vim.cmd("DiffviewOpen")
                end
                -- Pre-start Claude in background
                vim.defer_fn(function()
                    if _G.ClaudeTerminal then
                        _G.ClaudeTerminal.prestart()
                    end
                end, 500)
            end
        end, { desc = "Toggle diff view against main" })
    end,
}
