return {
  {
    'nvimtools/none-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.prettier,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            local group = vim.api.nvim_create_augroup('LspFormatOnSave', { clear = false })
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })

            vim.api.nvim_create_autocmd(
              'BufWritePre', {
                buffer = bufnr,
                group = group,
                callback = function()
                  vim.lsp.buf.format({ bufnr = bufnr, async = false })
                end,
                desc = 'Format on save'
              })
          end

          if client.supports_method("textDocument/rangeFormatting") then
            vim.keymap.set('x', '<leader>l', vim.lsp.buf.format, { buffer = bufnr, remap = false, desc = 'Format range' })
          end
        end,
      }
    end,
  }
}
