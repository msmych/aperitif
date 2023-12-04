---@diagnostic disable: undefined-global

require('mason').setup {}
local mason_lspconfig = require('mason-lspconfig')

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader><CR>', vim.lsp.buf.code_action, opts)
  vim.keymap.set('i', '<C-l>', function()
    vim.lsp.buf.format()
  end)
  vim.keymap.set('n', '<leader>l', function()
    vim.lsp.buf.format()
  end)
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
