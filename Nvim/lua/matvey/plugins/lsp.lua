---@diagnostic disable: undefined-global

local opts = { buffer = bufnr, remap = false }

local keymaps = function()
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader><F6>', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader><CR>', vim.lsp.buf.code_action, opts)
  vim.keymap.set('i', '<C-l>', function()
    vim.lsp.buf.format()
  end)
  vim.keymap.set('n', '<leader>l', function()
    vim.lsp.buf.format()
  end)
end

return {
  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      { 'j-hui/fidget.nvim', opts = {} },

      'folke/neodev.nvim',
    },
    priority = 40,
    config = function()
      require('mason').setup {}
      local mason_lspconfig = require('mason-lspconfig')

      local on_attach = function(_, bufnr)
        keymaps()
      end

      local servers = {
        lua_ls = {},
        rust_analyzer = {},
        tsserver = {},
        eslint = {},
        -- java_language_server = {},
        -- kotlin_language_server = {},
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
        end
      }
    end
  },

  -- Rust
  {
    'simrat39/rust-tools.nvim',
    priority = 20,
    config = function()
      local rt = require("rust-tools")
      local mason_registry = require('mason-registry')

      local codelldb = mason_registry.get_package('codelldb')
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

      local capabilities = vim.lsp.protocol.make_client_capabilities();
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities);

      rt.setup {
        dap = {
          adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
        },
        server = {
          capabilities = capabilities,
          on_attach = function(_, bufnr)
            keymaps()
            vim.keymap.set('n', '<leader>r', rt.hover_actions.hover_actions, { buffer = bufnr })
          end
        },
        tools = {
          hover_actions = {
            auto_focus = true,
          }
        }
      }
    end
  },
}
