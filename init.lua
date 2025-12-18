-- Set leader key before plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
require("config.lazy")

-- Load core config
require("core.options")
require("core.keymaps")
require("core.autocmds")
