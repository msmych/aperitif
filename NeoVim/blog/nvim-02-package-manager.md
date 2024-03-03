# Neovim configuration. Part 2. Package manager

In this part, you will learn how to install package manager for Nvim and how to install plugins with it.

## Install Lazy
Let's use [Lazy](https://github.com/folke/lazy.nvim) as package manager.
As you did several times in the previous part, create a separate config file in `~/.config/nvim/lua/matvey`.
This time call it `lazy.lua`. Put the following code:
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
```
When Nvim starts, this code will check whether Lazy is already installed, and will install it if not.

