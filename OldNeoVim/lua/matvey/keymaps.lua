---@diagnostic disable: undefined-global

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<leader>1', vim.cmd.Ex)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', "mzJ`z")

vim.keymap.set('n', '<C-d>', "<C-d>zz")
vim.keymap.set('n', '<C-u>', "<C-u>zz")
vim.keymap.set('n', '<C-f>', "<C-f>zz")
vim.keymap.set('n', '<C-b>', "<C-b>zz")

vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")

vim.keymap.set('x', '<leader>p', "\"_dP")
vim.keymap.set('n', '<leader>d', "\"_d")
vim.keymap.set('v', '<leader>d', "\"_d")

vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')

vim.keymap.set('n', ']e', vim.diagnostic.goto_next, { desc = 'Go to next error' })
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, { desc = 'Go to previous error' })
vim.keymap.set('n', '<leader><F1>', vim.diagnostic.open_float, { desc = 'Open floating error message' })

vim.keymap.set('n', 'nt', ':tabnew<CR>')
vim.keymap.set('n', 'nv', ':vsplit<CR>')
vim.keymap.set('n', 'nh', ':split<CR>')

vim.keymap.set('n', '<leader><right>', '<C-w>6>')
vim.keymap.set('n', '<leader><left>', '<C-w>6<')
vim.keymap.set('n', '<leader><up>', '<C-w>4+')
vim.keymap.set('n', '<leader><down>', '<C-w>4-')
