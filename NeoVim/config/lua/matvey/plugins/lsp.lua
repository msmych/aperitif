return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim',       opts = {} },
      'folke/neodev.nvim',
    },
    config = function()
      local mason = require('mason')
      mason.setup()
      local mason_lspconfig = require('mason-lspconfig')
      mason_lspconfig.setup()

      require('neodev').setup()

      local servers = {
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { disable = { 'missing-fields' } },
            completion = { callSnippet = 'Replace' }
          }
        },
        eslint = {},
        tsserver = {},
      }

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            settings = servers[server_name],
            capabilities = capabilities,
            on_attach = function(_, bufnr)
              local telescope = require 'telescope.builtin'

              vim.keymap.set('n', 'K', vim.lsp.buf.hover,
                { buffer = bufnr, remap = false, desc = 'LSP: hover documentation' })
              vim.keymap.set('n', '<leader><CR>', vim.lsp.buf.code_action,
                { buffer = bufnr, remap = false, desc = 'LSP: code action' })
              vim.keymap.set('n', '<leader><F6>', vim.lsp.buf.rename,
                { buffer = bufnr, remap = false, desc = 'LSP: rename' })
              vim.keymap.set('i', '<C-p>', vim.lsp.buf.signature_help,
                { buffer = bufnr, remap = false, desc = 'LSP: signature help' })
              vim.keymap.set('i', '<C-l>', vim.lsp.buf.format, { buffer = bufnr, remap = false, desc = 'LSP: format' })
              vim.keymap.set('n', '<leader>l', vim.lsp.buf.format,
                { buffer = bufnr, remap = false, desc = 'LSP: format' })
              vim.keymap.set('n', '<leader><F12>', telescope.lsp_document_symbols,
                { buffer = bufnr, remap = false, desc = 'LSP: document symbols' })
              vim.keymap.set('n', 'gd', telescope.lsp_definitions,
                { buffer = bufnr, remap = false, desc = 'LSP: go to definition' })
              vim.keymap.set('n', 'gr', telescope.lsp_references,
                { buffer = bufnr, remap = false, desc = 'LSP: search references' })
              vim.keymap.set('n', '<leader>so', telescope.lsp_dynamic_workspace_symbols,
                { buffer = bufnr, remap = false, desc = 'LSP: search symbols' })
            end,
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end
      }
    end,
  }
}
