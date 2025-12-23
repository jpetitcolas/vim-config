return {
    "rmagatti/auto-session",
    config = function()
        -- Exclude terminal buffers from sessions to avoid "Buffer with this name already exists" errors
        vim.opt.sessionoptions:remove("terminal")

        require("auto-session").setup({
            auto_restore_enabled = true,
            auto_save_enabled = true,
            auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
        })
    end,
}
