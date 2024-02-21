# NeoVim configuration

## 1. Fundamentals

### Install NeoVim

```bash
brew install neovim
```

### Config setup

```bash
mkdir ~/.config/nvim
cd ~/.config/nvim
nvim
```

Run `:Ex` to open Netrw. Hit `%` to create a new file. Call the file `init.lua`. Put `require('matvey')` to import custom configs. Run `:w` to save.

Open Netrw again (`:Ex`), this time hit `d` to create a new directory. Call it `lua`. Go inside and create another one: `matvey`. Go inside and create another file (`%`) called `init.lua`. Put `require('matvey.keymaps')` to import custom keymaps (don't forget `:w`).

Open Netrw, create new file called `keymaps.lua`. Put the following code:

```lua
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<leader>1', vim.cmd.Ex, { desc = 'Open Netrw' })
```

Run `:so` to source current file and then open Netrw, this time with `<Space>1`. Return to `lua/matvey/init.lua`, add `require('matvey.options')`. Create file `options.lua` and put the following code:

```lua
vim.wo.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a'

vim.o.clipboard = 'unnamedplus'

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.scrolloff = 8

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 20
```

### Install package manager

Add `require('matvey.lazy')` to `lua/matvey/init.lua`. Create `lazy.lua` and put the following code:

```lua
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({})
```

Exit NeoVim (`:q`) and re-open it (`nvim`). Run `:Lazy` to check that Lazy was installed. Close it with `:q`.

### Change theme

Open `lua/matvey/lazy.lua`, replace `require('lazy').setup({})` with `require('lazy').setup('matvey.plugins')`. Create directory `plugins`, add file `themes.lua`. Put the following code:

```lua
return {
  {
    {
      'rose-pine/neovim',
      name = 'rose-pine',
      priority = 1000,
      config = function()
        require('rose-pine').setup {}
        vim.cmd.colorscheme 'rose-pine'
      end
    }
  }
}
```

Re-open NeoVim to install theme.

### Advanced syntax support

Add `syntax.lua` to `plugins` directory. Put the following code:

```lua
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "lua", "query", "vim", "vimdoc" },
        auto_install = true,
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true
        },
      }
    end
  }
}
```

Re-open NeoVim to install Treesitter plugin and parsers. Open some config file, note that highlights became more granular.

Run `:InspectTree` and explore visual syntax tree of the current file. Jump between windows with `<Control-w><Control-w>`. Close tree with `:q`.
