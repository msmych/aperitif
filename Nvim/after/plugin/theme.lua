---@diagnostic disable: undefined-global

require('rose-pine').setup {
  variant = 'moon',
  disable_italics = true,
}

vim.cmd [[ colorscheme rose-pine ]]

vim.api.nvim_set_hl(0, "Normal", { bg = 'none' })
vim.api.nvim_set_hl(0, "NormalNC", { bg = 'none' })
vim.api.nvim_set_hl(0, "SignColumn", { bg = 'none' })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = 'none' })
vim.api.nvim_set_hl(0, "CursorLine", { bg = 'none' })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = 'none' })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = 'none' })
vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = 'none' })
