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

-- Claude terminal toggle (Alt+C)
map("n", "<A-c>", function()
    if _G.ClaudeTerminal then
        _G.ClaudeTerminal.toggle()
    else
        vim.notify("Claude terminal not loaded", vim.log.levels.WARN)
    end
end, { desc = "Toggle Claude terminal" })

map("t", "<A-c>", "<C-\\><C-n>:lua if _G.ClaudeTerminal then _G.ClaudeTerminal.hide() end<CR>", { desc = "Hide Claude terminal" })
