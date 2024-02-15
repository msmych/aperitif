---@diagnostic disable: undefined-global

return {
  -- Git
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>0', vim.cmd.G)
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      }
    }
  },

}
