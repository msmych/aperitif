---@diagnostic disable: undefined-global

-- Ensure Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- themes
  'navarasu/onedark.nvim',
  { 'rose-pine/neovim', name = 'rose-pine' },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  'nvim-treesitter/nvim-treesitter',
  'L3MON4D3/LuaSnip',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp',
  'mbbill/undotree',
  'mfussenegger/nvim-dap',
  'neovim/nvim-lspconfig',
  'rafamadriz/friendly-snippets',
  'rcarriga/nvim-dap-ui',
  'saadparwaiz1/cmp_luasnip',
  'simrat39/rust-tools.nvim',
  'tpope/vim-fugitive',
  'williamboman/mason-lspconfig.nvim',
  'williamboman/mason.nvim',
  'nvim-tree/nvim-web-devicons'
}

require("lazy").setup(plugins, {})
