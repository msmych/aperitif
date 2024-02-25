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
              require('matvey.utils').lsp_keymaps(bufnr)
            end,
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end
      }
    end,
  }
}
