local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Trim trailing whitespace on save
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
    group = "TrimWhitespace",
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- Return to last edit position
augroup("LastPosition", { clear = true })
autocmd("BufReadPost", {
    group = "LastPosition",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Close some filetypes with q
augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
    group = "CloseWithQ",
    pattern = { "help", "man", "qf", "checkhealth" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})
