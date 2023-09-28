require('mason').setup {}
local mason_lspconfig = require('mason-lspconfig')


local on_attach = function(_, _)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
  vim.keymap.set('n', '<leader>cf', function()
    vim.lsp.buf.format()
  end)
  -- vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format(), {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

local servers = {
  lua_ls = {},
  rust_analyzer = {},
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

