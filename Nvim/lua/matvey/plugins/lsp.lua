---@diagnostic disable: undefined-global

local opts = function(bufnr, desc) return { buffer = bufnr, remap = false, desc = 'LSP: ' .. desc } end

local keymaps = function(bufnr)
  vim.keymap.set('n', '<leader><F6>', vim.lsp.buf.rename, opts(bufnr, 'Rename'))
  vim.keymap.set('n', '<leader><CR>', vim.lsp.buf.code_action, opts(bufnr, 'Code action'))
  vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, opts(bufnr, 'Go to definition'))
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts(bufnr, 'Go to references'))
  vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, opts(bufnr, 'Go to implementations'))
  vim.keymap.set('n', '<leader><F12>', require('telescope.builtin').lsp_document_symbols, opts(bufnr, 'Document symbols'))
  vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    opts(bufnr, 'Workspace symbols'))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts(bufnr, 'Hover documentation'))
  vim.keymap.set('i', '<C-p>', vim.lsp.buf.signature_help, opts(bufnr, 'Signature documentation'))
  vim.keymap.set('i', '<C-l>', function()
    vim.lsp.buf.format()
  end, opts(bufnr, 'Format'))
  vim.keymap.set('n', '<leader>l', function()
    vim.lsp.buf.format()
  end, opts(bufnr, 'Format'))
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
        keymaps(bufnr)
      end

      local servers = {
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { disable = { 'missing-fields' } },
          }
        },
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
            settings = servers[server_name],
          }
        end
      }
    end
  },

  {
    'folke/neodev.nvim',
    config = function()
      require('neodev').setup()
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
            keymaps(bufnr)
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
