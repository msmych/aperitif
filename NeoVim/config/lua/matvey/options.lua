-- Ruler with relative numbers
vim.wo.number = true
vim.o.relativenumber = true

-- Update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 600

-- Enable mouse
vim.o.mouse = 'a'

-- Synchronize clipboards
vim.o.clipboard = 'unnamedplus'

-- Go to new split window
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Indents
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.o.breakindent = true

-- Search
vim.o.hlsearch = false
vim.opt.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Completion options
vim.o.completeopt = 'menuone,noselect'

-- No wrap
vim.opt.wrap = false

-- Keep some distance from the top / bottom
vim.opt.scrolloff = 8

-- Show command
vim.opt.showcmd = true

-- No swapfile, no backup, use undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
