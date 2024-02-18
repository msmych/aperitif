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

      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')

      local function find_git_root()
        -- Use the current buffer's path as the starting point for the git search
        local current_file = vim.api.nvim_buf_get_name(0)
        local current_dir
        local cwd = vim.fn.getcwd()
        -- If the buffer is not associated with a file, return nil
        if current_file == "" then
          current_dir = cwd
        else
          -- Extract the directory from the current file's path
          current_dir = vim.fn.fnamemodify(current_file, ":h")
        end

        -- Find the Git root directory from the current file's path
        local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")
            [1]
        if vim.v.shell_error ~= 0 then
          print("Not a git repository. Searching on current working directory")
          return cwd
        end
        return git_root
      end

      -- Custom live_grep function to search in git root
      local function live_grep_git_root()
        local git_root = find_git_root()
        if git_root then
          builtin.live_grep({ search_dirs = { git_root } })
        end
      end

      local function find_files_git_root()
        local git_root = find_git_root()
        if git_root then
          builtin.find_files({ search_dirs = { git_root } })
        end
      end

      vim.keymap.set('n', '<leader>e', builtin.oldfiles, { desc = 'Find recently opened files' })
      vim.keymap.set('n', '<leader><Tab>', builtin.buffers, { desc = 'Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>o', find_files_git_root, { desc = 'Search files' })
      vim.keymap.set('n', '<leader>f', live_grep_git_root, { desc = 'Search by grep on git root' })
      vim.keymap.set('n', '<leader>6', require('telescope.builtin').diagnostics, { desc = 'Search diagnostics' })
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').resume, { desc = 'Search resume' })
    end
  },

}
