local function get_project_name()
    local cwd = vim.fn.getcwd()
    return vim.fn.fnamemodify(cwd, ":t")
end

local function get_notes_dir()
    local home = vim.fn.expand("~")
    local project = get_project_name()
    return home .. "/.claude/" .. project
end

local function get_notes_path()
    return get_notes_dir() .. "/review-notes.md"
end

local function ensure_notes_dir()
    local dir = get_notes_dir()
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end
end

local function add_note()
    local file = vim.fn.expand("%:.")
    local line = vim.fn.line(".")
    local line_content = vim.fn.getline(".")

    vim.ui.input({ prompt = "Review note: " }, function(note)
        if not note or note == "" then
            return
        end

        ensure_notes_dir()
        local notes_path = get_notes_path()

        local content = string.format(
            "## %s:%d\n> %s\n\n%s\n\n---\n\n",
            file,
            line,
            line_content,
            note
        )

        local f = io.open(notes_path, "a")
        if f then
            f:write(content)
            f:close()
            vim.notify("Note added", vim.log.levels.INFO)
        else
            vim.notify("Failed to write note", vim.log.levels.ERROR)
        end
    end)
end

local function open_notes()
    local notes_path = get_notes_path()
    if vim.fn.filereadable(notes_path) == 1 then
        vim.cmd("vsplit " .. notes_path)
    else
        vim.notify("No review notes yet", vim.log.levels.WARN)
    end
end

local function clear_notes()
    local notes_path = get_notes_path()
    if vim.fn.filereadable(notes_path) == 1 then
        vim.fn.delete(notes_path)
        vim.notify("Review notes cleared", vim.log.levels.INFO)
    else
        vim.notify("No review notes to clear", vim.log.levels.WARN)
    end
end

local function send_to_claude()
    local notes_path = get_notes_path()
    if vim.fn.filereadable(notes_path) == 0 then
        vim.notify("No review notes to send", vim.log.levels.WARN)
        return
    end

    if not _G.ClaudeTerminal then
        vim.notify("Claude terminal not loaded", vim.log.levels.ERROR)
        return
    end

    local lines = vim.fn.readfile(notes_path)
    local content = table.concat(lines, "\n")

    _G.ClaudeTerminal.send_when_ready(content, {
        on_success = function()
            vim.notify("Notes sent to Claude", vim.log.levels.INFO)
            vim.fn.delete(notes_path)
        end,
    })
end

local function ask_claude()
    local file = vim.fn.expand("%:.")
    local line = vim.fn.line(".")
    local line_content = vim.fn.getline(".")

    vim.ui.input({ prompt = "Ask Claude: " }, function(question)
        if not question or question == "" then
            return
        end

        if not _G.ClaudeTerminal then
            vim.notify("Claude terminal not loaded", vim.log.levels.ERROR)
            return
        end

        local content = string.format(
            "## %s:%d\n> %s\n\n%s",
            file,
            line,
            line_content,
            question
        )

        _G.ClaudeTerminal.send_when_ready(content, {
            on_success = function()
                vim.notify("Sent to Claude", vim.log.levels.INFO)
            end,
        })
    end)
end

return {
    dir = ".",
    name = "review-notes",
    config = function()
        vim.keymap.set("n", "<leader>rn", add_note, { desc = "Add review note" })
        vim.keymap.set("n", "<leader>ro", open_notes, { desc = "Open review notes" })
        vim.keymap.set("n", "<leader>rc", send_to_claude, { desc = "Send review to Claude" })
        vim.keymap.set("n", "<leader>ac", ask_claude, { desc = "Ask Claude about this line" })
    end,
}
