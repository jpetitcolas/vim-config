-- Bootstrap lazy.nvim (clone if not present)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Setup with plugins directory
require("lazy").setup("plugins", {
    install = { colorscheme = { "rose-pine-moon" } },
    checker = { enabled = true, notify = false },
})
