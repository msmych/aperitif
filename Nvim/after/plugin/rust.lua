local rt = require("rust-tools")
local mason_registry = require('mason-registry')

local codelldb = mason_registry.get_package('codelldb')
local extension_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

local capabilities = vim.lsp.protocol.make_client_capabilities();
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities);

rt.setup({
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
  },
  server = {
    capabilities = capabilities,
    on_attach = function(_, bufnr)
      local opts = { buffer = bufnr, remap = false }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<leader>rr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, opts)
      vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', '<leader>cf', function()
        vim.lsp.buf.format()
      end)
      vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)

      -- Hover actions
      vim.keymap.set("n", "<leader>r", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
  tools = {
    hover_actions = {
      auto_focus = true
    }
  }
})
