---@diagnostic disable: undefined-global

local rt = require("rust-tools")

local capabilities = vim.lsp.protocol.make_client_capabilities();
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities);

rt.setup {
  server = {
    capabilities = capabilities,
    on_attach = function(_, bufnr)
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
  },
  tools = {
    hover_actions = {
      auto_focus = true,
    }
  }
}
