-- Do nothing on single space
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<leader>q', ':bd<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>Q', ':qa!<CR>', { desc = 'Quit' })
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Write' })

vim.keymap.set('n', '<leader><right>', '<C-w>6>', { desc = '[+] Window width' })
vim.keymap.set('n', '<leader><left>', '<C-w>6<', { desc = '[-] Window width' })
vim.keymap.set('n', '<leader><up>', '<C-w>4+', { desc = '[+] Window height' })
vim.keymap.set('n', '<leader><down>', '<C-w>4-', { desc = '[-] Window height' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Go to right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Go to down window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Go to up window' })

vim.keymap.set('x', '<leader>p', "\"_dP", { desc = 'Paste and keep clipboard value' })

vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })

-- Errors
vim.keymap.set('n', '<F2>', vim.diagnostic.goto_next, { desc = 'Go to next error' })
vim.keymap.set('n', '<F14>', vim.diagnostic.goto_prev, { desc = 'Go to previous error' })
vim.keymap.set('n', '<leader><F1>', vim.diagnostic.open_float, { desc = 'Show error message' })
vim.keymap.set('n', '<leader>6', vim.diagnostic.setloclist, { desc = 'Errors quicklist' })

-- Git
vim.keymap.set('n', '<leader>gh', ':diffget //2<CR>', { desc = 'Git get left' })
vim.keymap.set('n', '<leader>gl', ':diffget //3<CR>', { desc = 'Git get right' })

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
