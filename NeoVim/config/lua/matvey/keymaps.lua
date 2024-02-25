-- Set map leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Do nothing on single space
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Write' })
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Quit' })

vim.keymap.set('n', '<leader><right>', '<C-w>6>', { desc = '[+] Window width' })
vim.keymap.set('n', '<leader><left>', '<C-w>6<', { desc = '[-] Window width' })
vim.keymap.set('n', '<leader><up>', '<C-w>4+', { desc = '[+] Window height' })
vim.keymap.set('n', '<leader><down>', '<C-w>4-', { desc = '[-] Window height' })

vim.keymap.set('x', '<leader>p', "\"_dP", { desc = 'Paste and keep clipboard value' })

vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })

-- Errors
vim.keymap.set('n', ']e', vim.diagnostic.goto_next, { desc = 'Go to next error' })
vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, { desc = 'Go to previous error' })
vim.keymap.set('n', '<leader><F1>', vim.diagnostic.open_float, { desc = 'Show error message' })

-- <C-c> is more convenient than <Esc>
vim.keymap.set('i', '<C-c>', '<Esc>')

-- Re-center on vertical move
vim.keymap.set('n', '<C-d>', "<C-d>zz")
vim.keymap.set('n', '<C-u>', "<C-u>zz")
vim.keymap.set('n', '<C-f>', "<C-f>zz")
vim.keymap.set('n', '<C-b>', "<C-b>zz")

-- Re-center on search
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")
