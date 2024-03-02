return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup()
      require('mini.surround').setup()
      require('mini.statusline').setup {
        use_icons = false,
      }
      require('mini.tabline').setup {
        use_icons = false,
      }
    end
  },
  {
    'michaelrommel/nvim-silicon',
    lazy = true,
    cmd = 'Silicon',
    config = function()
      require('silicon').setup {
        font = 'Hack'
      }
    end
  }
}
