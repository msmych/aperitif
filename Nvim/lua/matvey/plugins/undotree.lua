---@diagnostic disable: undefined-global

return {
  -- Undo
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>7', vim.cmd.UndotreeToggle)
    end
  },
}
