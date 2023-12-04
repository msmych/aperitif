require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "typescript", "rust", "java", "kotlin" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<leader>[',
      node_incremental = '<leader>[',
      node_decremental = '<leader>]',
      scope_incremental = '<leader>s[',
      scope_decremental = '<leader>s]',
    }
  }
}
