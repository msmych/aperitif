return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>0', vim.cmd.G, { desc = 'Open Git' })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })

        vim.keymap.set('n', '<leader>z', gs.reset_buffer, { buffer = bufnr, desc = 'Git reset buffer' })

        local hl_groups = {
           'GitSignsAdd',
           'GitSignsChange',
           'GitSignsDelete',
           'GitSignsTopdelete',
           'GitSignsChangedelete',
        }
        for _, hl_group in ipairs(hl_groups) do
          vim.api.nvim_command("highlight " .. hl_group .. " guibg=none")
        end
      end
    }
  },
  'mbbill/undotree',
}
