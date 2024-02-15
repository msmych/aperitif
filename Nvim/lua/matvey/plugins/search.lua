---@diagnostic disable: undefined-global

return {
  -- Search
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>e', builtin.oldfiles, {})
      vim.keymap.set('n', '<leader><Tab>', builtin.buffers, {})

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, {})

      vim.keymap.set('n', '<leader>o', builtin.git_files, {})
      vim.keymap.set('n', '<leader>3', builtin.find_files, {})
      vim.keymap.set('n', '<leader>f', builtin.live_grep, {})

      pcall(require('telescope').load_extension, 'fzf')
    end
  },

}
