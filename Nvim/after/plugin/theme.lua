---@diagnostic disable: undefined-global

-- require('onedark').load()

require('rose-pine').setup {
  variant = 'moon',
  disable_italics = true,
}

vim.cmd [[ colorscheme rose-pine ]]

local hl_groups = {
  'Normal',
  'NormalNC',
  'SignColumn',
  'EndOfBuffer',

  'TelescopeNormal',
  'TelescopeBorder',
  'TelescopePromptNormal',

  'DiffAdd',
  'GitSignsAdd',
  'DiffChange',
  'GitSignsChange',
  'DiffDelete',
  'GitSignsDelete',
  'GitSignsTopdelete',
  'GitSignsChangedelete',
}

for _, hl_group in ipairs(hl_groups) do
  vim.api.nvim_command("highlight " .. hl_group .. " guibg=none")
end

vim.api.nvim_command("highlight link debugPC CursorLine")
