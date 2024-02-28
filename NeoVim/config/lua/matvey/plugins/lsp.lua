return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      { 'j-hui/fidget.nvim', opts = {} },

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
            runtime = { version = 'LuaJIT' },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { disable = { 'missing-fields' } },
          }
        },
        eslint = {},
        tsserver = {},
      }

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      mason_lspconfig.setup_handlers {
        function(server_name)
          local server = servers[server_name] or {}
          require('lspconfig')[server_name].setup {
            cmp = server.cmd,
            settings = servers[server_name],
            capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {}),
            filetypes = server.filetypes,
            on_attach = function(client, bufnr)
              require('matvey.utils').setup_lsp(client, bufnr)
            end,
          }
        end
      }
    end,
  }
}
