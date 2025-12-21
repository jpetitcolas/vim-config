-- Custom Claude terminal integration (replaces greggh/claude-code.nvim)
local M = {}

-- State
M.buf = nil
M.chan = nil
M.win = nil

-- Cleanup any existing Claude terminals (e.g., from restored sessions)
local function cleanup_old_terminals()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) then
            local name = vim.api.nvim_buf_get_name(buf)
            if name:match("claude%-terminal") or (name:match("term://") and name:lower():match("claude")) then
                -- Close any windows showing this buffer
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    if vim.api.nvim_win_get_buf(win) == buf then
                        pcall(vim.api.nvim_win_close, win, true)
                    end
                end
                -- Delete the buffer
                pcall(vim.api.nvim_buf_delete, buf, { force = true })
            end
        end
    end
    M.buf = nil
    M.chan = nil
    M.win = nil
end

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
    -- Ensure no duplicate terminals
    cleanup_old_terminals()

    -- Save current window/buffer
    local prev_win = vim.api.nvim_get_current_win()

    -- Create a small hidden split for the terminal
    vim.cmd("botright 1split")
    local term_win = vim.api.nvim_get_current_win()

    -- Create a new buffer and switch to it
    M.buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_win_set_buf(term_win, M.buf)

    -- Open terminal in this buffer
    M.chan = vim.fn.termopen("claude", {
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

    -- Create bottom split
    vim.cmd("botright split")
    M.win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(M.win, M.buf)

    -- Resize to 100% (full screen)
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

function M.prestart()
    if not is_valid() then
        create_terminal()
    end
end

function M.is_ready()
    if not is_valid() then
        return false
    end
    -- Check if terminal has output (Claude is ready)
    local lines = vim.api.nvim_buf_get_lines(M.buf, 0, -1, false)
    local content_lines = 0
    for _, line in ipairs(lines) do
        if line ~= "" then
            content_lines = content_lines + 1
        end
    end
    return content_lines > 2
end

function M.send(text)
    if not is_valid() then
        return false
    end

    -- Focus terminal window
    if M.win and vim.api.nvim_win_is_valid(M.win) then
        vim.api.nvim_set_current_win(M.win)
    end

    -- Enter terminal mode and send keys as if typed
    vim.cmd("startinsert")
    vim.defer_fn(function()
        -- Use feedkeys to simulate typing (t = as if typed, i = insert mode)
        vim.api.nvim_feedkeys(text, "t", false)
        vim.defer_fn(function()
            -- Send Enter key
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "t", false)
        end, 100)
    end, 50)
    return true
end

function M.send_when_ready(text, opts)
    opts = opts or {}
    local max_retries = opts.max_retries or 30
    local interval = opts.interval or 200
    local on_success = opts.on_success
    local on_error = opts.on_error

    local function try_send(retries)
        if M.is_ready() then
            M.send(text)
            if on_success then on_success() end
        elseif retries < max_retries then
            vim.defer_fn(function() try_send(retries + 1) end, interval)
        else
            if on_error then
                on_error()
            else
                vim.notify("Claude not ready after timeout", vim.log.levels.ERROR)
            end
        end
    end

    M.show()
    try_send(0)
end

function M.get_channel()
    return M.chan
end

function M.is_visible()
    return is_visible()
end

-- Expose module globally for other plugins
_G.ClaudeTerminal = M

return {
    dir = ".",
    name = "claude-terminal",
    config = function()
        -- Clean up any old Claude terminals from previous sessions
        cleanup_old_terminals()
    end,
}
