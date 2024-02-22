return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup {
        extensions = {
          file_browser = {
            theme = 'ivy',
            path = '%:p:h',
            select_buffer = true,
            hijack_netrw = true,
          }
        }
      }

      telescope.load_extension('fzf')
      telescope.load_extension('file_browser')

      local builtin = require('telescope.builtin')
      local file_browser = telescope.extensions.file_browser

      local utils = require('matvey.utils')

      vim.keymap.set('n', '<leader>1', file_browser.file_browser, { desc = 'Open file browser' })
      vim.keymap.set('n', '<leader><Tab>', builtin.buffers, { desc = 'Search buffers' })
      vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Search in current buffer' })
      vim.keymap.set('n', '<leader>2', builtin.marks, { desc = 'Search marks' })
      vim.keymap.set('n', '<leader>6', builtin.diagnostics, { desc = 'Search errors' })
      vim.keymap.set('n', '<leader>9', builtin.git_commits, { desc = 'Search Git commits' })
      vim.keymap.set('n', '<leader>o', function()
        if utils.find_git_root() ~= nil then
          builtin.git_files()
        else
          builtin.find_files {
            hidden = true,
            file_ignore_patterns = { 'node_modules/' },
          }
        end
      end, { desc = 'Search Git files' })
      vim.keymap.set('n', '<leader>O', function()
        builtin.find_files {
          cwd = utils.find_git_root(),
          hidden = true,
          file_ignore_patterns = { '.git/', 'node_modules/' },
        }
      end, { desc = 'Search files in Git root' })
      vim.keymap.set('n', '<leader>e', builtin.oldfiles, { desc = 'Search old files' })
      vim.keymap.set('n', '<leader>f', builtin.live_grep, { desc = 'Search by grep' })
      vim.keymap.set('n', '<leader><space>', function()
        builtin.find_files {
          cwd = utils.find_git_root(),
          hidden = true,
        }
      end, { desc = 'Search all files' })
    end
  }
}
