local M = {}

M.find_git_root = function()
  local current_file = vim.api.nvim_buf_get_name(0)

  local current_dir
  local cwd = vim.fn.getcwd()
  if current_file == "" then
    current_dir = cwd
  else
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]

  if vim.v.shell_error ~= 0 then
    return nil
  end
  return git_root
end

M.lsp_keymaps = function(bufnr)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, remap = false, desc = 'LSP: hover documentation' })
  vim.keymap.set('n', '<leader><CR>', vim.lsp.buf.code_action,
    { buffer = bufnr, remap = false, desc = 'LSP: code action' })
  vim.keymap.set('n', '<leader><F6>', vim.lsp.buf.rename, { buffer = bufnr, remap = false, desc = 'LSP: rename' })
  vim.keymap.set('i', '<C-p>', vim.lsp.buf.signature_help,
    { buffer = bufnr, remap = false, desc = 'LSP: signature help' })
  vim.keymap.set('i', '<C-l>', vim.lsp.buf.format, { buffer = bufnr, remap = false, desc = 'LSP: format' })
  vim.keymap.set('n', '<leader>l', vim.lsp.buf.format, { buffer = bufnr, remap = false, desc = 'LSP: format' })

  local telescope = require 'telescope.builtin'

  vim.keymap.set('n', '<leader><F12>', telescope.lsp_document_symbols,
    { buffer = bufnr, remap = false, desc = 'LSP: document symbols' })
  vim.keymap.set('n', 'gd', telescope.lsp_definitions,
    { buffer = bufnr, remap = false, desc = 'LSP: go to definition' })
  vim.keymap.set('n', 'gD', telescope.lsp_type_definitions, { buffer = bufnr, remap = false, desc = 'LSP: go to type' })
  vim.keymap.set('n', 'gr', telescope.lsp_references,
    { buffer = bufnr, remap = false, desc = 'LSP: search references' })
  vim.keymap.set('n', 'gi', telescope.lsp_implementations,
    { buffer = bufnr, remap = false, desc = 'LSP: search implementations' })
  vim.keymap.set('n', '<leader>so', telescope.lsp_dynamic_workspace_symbols,
    { buffer = bufnr, remap = false, desc = 'LSP: search symbols' })
end

return M
