---@diagnostic disable: undefined-global

require('dapui').setup()

local dap = require('dap')
local dapui = require('dapui')

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end

dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end

dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

vim.keymap.set('n', '<leader><F8>', ':DapToggleBreakpoint<CR>')
vim.keymap.set('n', '<F7', ':DapStepInto<CR>')
vim.keymap.set('n', '<F8>', ':DapStepOver<CR>')
vim.keymap.set('n', '<F9>', ':DapContinue<CR>')