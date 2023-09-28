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
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<leader>cf', function()
        vim.lsp.buf.format()
      end)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
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
