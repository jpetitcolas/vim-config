local opt = vim.opt

-- Line numbers
opt.number = true

-- Indentation (4 spaces)
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- UI
opt.termguicolors = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false

-- Clipboard
opt.clipboard = "unnamedplus"

-- Files
opt.swapfile = false
opt.undofile = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300
