-- Persistent terminal integration
local M = {}

-- State
M.buf = nil
M.chan = nil
M.win = nil

local function is_valid()
    return M.buf and vim.api.nvim_buf_is_valid(M.buf) and M.chan
end

local function is_visible()
    if not is_valid() then
        return false
    end
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == M.buf then
            M.win = win
            return true
        end
    end
    return false
end

local function create_terminal()
    -- Save current window
    local prev_win = vim.api.nvim_get_current_win()

    -- Create a small hidden split for the terminal
    vim.cmd("botright 1split")
    local term_win = vim.api.nvim_get_current_win()

    -- Create a new buffer and switch to it
    M.buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_win_set_buf(term_win, M.buf)

    -- Open terminal in this buffer
    M.chan = vim.fn.termopen(vim.o.shell, {
        on_exit = function()
            M.buf = nil
            M.chan = nil
            M.win = nil
        end,
    })

    -- Set buffer options to persist between show/hide
    vim.bo[M.buf].buflisted = false
    vim.bo[M.buf].bufhidden = "hide"

    -- Close the temporary window (keeps buffer running)
    vim.api.nvim_win_close(term_win, false)

    -- Return to previous window
    vim.api.nvim_set_current_win(prev_win)
end

local function show_terminal()
    if not is_valid() then
        create_terminal()
    end

    if is_visible() then
        return
    end

    -- Create full screen split
    vim.cmd("botright split")
    M.win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(M.win, M.buf)

    -- Resize to full screen
    local height = vim.o.lines
    vim.cmd("resize " .. height)

    -- Enter terminal mode
    vim.cmd("startinsert")
end

local function hide_terminal()
    if M.win and vim.api.nvim_win_is_valid(M.win) then
        vim.api.nvim_win_close(M.win, false)
        M.win = nil
    end
end

local function toggle_terminal()
    if is_visible() then
        hide_terminal()
    else
        show_terminal()
    end
end

-- Public API
function M.toggle()
    toggle_terminal()
end

function M.show()
    show_terminal()
end

function M.hide()
    hide_terminal()
end

-- Expose module globally
_G.Terminal = M

return {
    dir = ".",
    name = "terminal",
    config = function() end,
}
