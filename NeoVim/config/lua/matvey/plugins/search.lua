return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          return vim.fn.executable 'make' == 1
        end
      },
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-dap.nvim',
    },
    config = function()
      local telescope = require('telescope')

      local themes = require('telescope.themes')

      telescope.setup {
        defaults = {
          layout_strategy = 'flex',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
            },
            vertical = {
              prompt_position = 'top',
              mirror = true,
            },
            center = {
              mirror = true,
            },
          },
          sorting_strategy = 'ascending',
          mappings = {
            i = {
            },
            n = {
            },
          },
        },
        pickers = {
          buffers = {
            mappings = {
              n = {
                ['d'] = require("telescope.actions").delete_buffer
              }
            }
          }
        },
        extensions = {
          file_browser = {
            hidden = true,
            theme = 'ivy',
            path = '%:p:h',
            select_buffer = true,
            hijack_netrw = true,
          },
          ['ui-select'] = {
            themes.get_dropdown()
          },
        }
      }

      telescope.load_extension('fzf')
      telescope.load_extension('file_browser')
      telescope.load_extension('ui-select')
      telescope.load_extension('dap')

      local builtin = require('telescope.builtin')
      local file_browser = telescope.extensions.file_browser
      local dap = telescope.extensions.dap

      local utils = require('matvey.utils')

      vim.keymap.set('n', '<F13>', builtin.help_tags, { desc = 'Search help' })
      vim.keymap.set('n', '<leader><Tab>', builtin.buffers, { desc = 'Search buffers' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(themes.get_dropdown())
      end, { desc = 'Search in current buffer' })
      vim.keymap.set('n', '<leader>?', function()
        builtin.live_grep { grep_open_files = true, prompt_title = 'Search in open files' }
      end, { desc = 'Search in open files' })
      vim.keymap.set('n', '<leader>1', file_browser.file_browser, { desc = 'Open file browser' })
      vim.keymap.set('n', '<leader>2', builtin.marks, { desc = 'Search marks' })
      vim.keymap.set('n', '<leader>@', dap.list_breakpoints, { desc = 'Search breakpoints' })
      vim.keymap.set('n', '<leader>3', builtin.builtin, { desc = 'Open search' })
      vim.keymap.set('n', '<leader>^', builtin.diagnostics, { desc = 'Search errors' })
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
          hidden = true,
          file_ignore_patterns = { '.git/', 'node_modules/' },
        }
      end, { desc = 'Search files in Git root' })
      vim.keymap.set('n', '<leader>e', builtin.oldfiles, { desc = 'Search old files' })
      vim.keymap.set('n', '<leader>f', function()
        builtin.grep_string {
          search = vim.fn.input('Search: '),
          prompt_title = 'Search by grep',
        }
      end, { desc = 'Search by grep' })
      vim.keymap.set('n', '<leader>F', builtin.live_grep, { desc = 'Search by grep' })
      vim.keymap.set('n', '<leader><space>', function()
        builtin.find_files {
          cwd = utils.find_git_root(),
          hidden = true,
        }
      end, { desc = 'Search all files' })
      vim.keymap.set('n', '<leader>*', builtin.grep_string, { desc = 'Search word under cursor' })
      vim.keymap.set('n', '<leader>;', builtin.resume, { desc = 'Resume search' })
    end
  }
}
