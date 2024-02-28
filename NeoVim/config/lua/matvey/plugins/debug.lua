return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      require('mason-nvim-dap').setup {
        automatic_setup = true,
        ensure_installed = {
          'codelldb',
        },
      }

      vim.keymap.set('n', '<F9>', dap.continue, { desc = 'Debug: continue' })
      vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Debug: step into' })
      vim.keymap.set('n', '<F8>', dap.step_over, { desc = 'Debug: step over' })
      vim.keymap.set('n', '<leader><F8>', dap.toggle_breakpoint, { desc = 'Debug: toggle breakpoint' })

      dapui.setup {
        icons = {
          expanded = '▾',
          collapsed = '▸',
          current_frame = '*'
        },
        controls = {
          icons = {
            pause = '⏸',
            play = '▶',
            step_into = '⏎',
            step_over = '⏭',
            step_out = '⏮',
            step_back = 'b',
            run_last = '▶▶',
            terminate = '⏹',
            disconnect = '⏏',
          },
        },
      }

      vim.keymap.set('n', '<leader>5', dapui.toggle, { desc = 'Toggle debug' })

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  }
}
