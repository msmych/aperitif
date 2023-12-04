---@diagnostic disable: undefined-global

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>e', builtin.oldfiles, {})
vim.keymap.set('n', '<leader><space>', builtin.buffers, {})
vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, {})

vim.keymap.set('n', '<leader>o', builtin.git_files, {})
vim.keymap.set('n', '<leader>O', builtin.find_files, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})

