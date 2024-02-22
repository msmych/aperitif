vim.cmd.colorscheme 'habamax'

-- Show sign column
vim.opt.signcolumn = "yes"

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.o.termguicolors = true

-- Some fix
vim.opt.isfname:append("@-@")
