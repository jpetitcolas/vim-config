local map = vim.keymap.set

-- Save with Ctrl+S
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Move lines with Alt+Up/Down
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })

-- Window navigation with Ctrl+arrows
map("n", "<C-Left>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-Down>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-Up>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-Right>", "<C-w>l", { desc = "Go to right window" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear highlight" })

-- Terminal mode navigation
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-S-v>", function()
    local clipboard = vim.fn.getreg("+")
    local chan = vim.b.terminal_job_id
    if chan then
        vim.api.nvim_chan_send(chan, clipboard)
    end
end, { desc = "Paste in terminal" })
-- When in terminal buffer (normal mode), Enter re-enters terminal mode
vim.api.nvim_create_autocmd("FileType", {
    pattern = "terminal",
    callback = function()
        vim.keymap.set("n", "<CR>", "i", { buffer = true, desc = "Enter terminal mode" })
    end,
})

-- Resize windows with Ctrl+Alt+arrows
map("n", "<C-A-Up>", "<cmd>resize +2<cr>", { desc = "Increase height" })
map("n", "<C-A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
map("n", "<C-A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
map("n", "<C-A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })

-- Helper to close diffview if open
local function close_diffview()
    local ok, lib = pcall(require, "diffview.lib")
    if ok and lib.get_current_view() then
        vim.cmd("DiffviewClose")
    end
end

-- Switch to Terminal (Alt+T) - hides Claude and closes Diffview
map("n", "<A-t>", function()
    if _G.ClaudeTerminal then _G.ClaudeTerminal.hide() end
    close_diffview()
    if _G.Terminal then
        _G.Terminal.show()
    else
        vim.notify("Terminal not loaded", vim.log.levels.WARN)
    end
end, { desc = "Switch to terminal" })

map("t", "<A-t>", function()
    -- Exit terminal mode first
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
    vim.schedule(function()
        local current_buf = vim.api.nvim_get_current_buf()
        if _G.ClaudeTerminal and _G.ClaudeTerminal.buf == current_buf then
            -- In Claude, switch to Terminal
            _G.ClaudeTerminal.hide()
            if _G.Terminal then _G.Terminal.show() end
        else
            -- In Terminal, hide it
            if _G.Terminal then _G.Terminal.hide() end
        end
    end)
end, { desc = "Switch to/hide terminal" })

-- Switch to Claude (Alt+C) - hides Terminal and closes Diffview
map("n", "<A-c>", function()
    if _G.Terminal then _G.Terminal.hide() end
    close_diffview()
    if _G.ClaudeTerminal then
        _G.ClaudeTerminal.show()
    else
        vim.notify("Claude terminal not loaded", vim.log.levels.WARN)
    end
end, { desc = "Switch to Claude" })

map("t", "<A-c>", function()
    -- Exit terminal mode first
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
    vim.schedule(function()
        local current_buf = vim.api.nvim_get_current_buf()
        if _G.Terminal and _G.Terminal.buf == current_buf then
            -- In Terminal, switch to Claude
            _G.Terminal.hide()
            if _G.ClaudeTerminal then _G.ClaudeTerminal.show() end
        else
            -- In Claude, hide it
            if _G.ClaudeTerminal then _G.ClaudeTerminal.hide() end
        end
    end)
end, { desc = "Switch to/hide Claude" })

-- Switch to Diffview from terminal (Alt+D)
map("t", "<A-d>", function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
    vim.schedule(function()
        if _G.Terminal then _G.Terminal.hide() end
        if _G.ClaudeTerminal then _G.ClaudeTerminal.hide() end
        vim.cmd("DiffviewOpen")
    end)
end, { desc = "Switch to diff view" })

-- Switch to Explorer from terminal (Alt+E)
map("t", "<A-e>", function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
    vim.schedule(function()
        if _G.Terminal then _G.Terminal.hide() end
        if _G.ClaudeTerminal then _G.ClaudeTerminal.hide() end
        vim.cmd("Neotree toggle")
    end)
end, { desc = "Switch to explorer" })
