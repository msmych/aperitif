return {
  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    ft = { 'rust' },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            require('matvey.utils').lsp_keymaps(bufnr)

            vim.keymap.set('n', '<leader><CR>', function() vim.cmd.RustLsp('codeAction') end,
              { remap = false, buffer = bufnr, desc = 'LSP: Code actions' })
            vim.keymap.set('n', '<leader>r', function() vim.cmd.RustLsp { 'runnables', bang = true } end,
              { remap = false, buffer = bufnr, desc = 'Re-run' })
            vim.keymap.set('n', '<leader>R', function() vim.cmd.RustLsp('runnables') end,
              { remap = false, buffer = bufnr, desc = 'Run' })
            vim.keymap.set('n', '<leader>dr', function() vim.cmd.RustLsp { 'debuggables', bang = true } end,
              { remap = false, buffer = bufnr, desc = 'Re-debug' })
            vim.keymap.set('n', '<leader>dR', function() vim.cmd.RustLsp('debuggables') end,
              { remap = false, buffer = bufnr, desc = 'Debug' })
            vim.keymap.set('n', '<leader>tr', function() vim.cmd.RustLsp { 'testables', bang = true } end,
              { remap = false, buffer = bufnr, desc = 'Re-test' })
            vim.keymap.set('n', '<leader>tR', function() vim.cmd.RustLsp('testables') end,
              { remap = false, buffer = bufnr, desc = 'Test' })
          end
        },
      }
    end
  }
}
