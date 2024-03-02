# Neovim configuration. Part 1. Basics

In the first part, you will learn how to do basic customizations for your Neovim.

Keep in mind that:
* The main goal is to show you what can be achieved in Neovim config, the specific choice of options is opinionated. Feel free to explore different other possibilities and adjust configs to your taste.
* Many keymaps and some practices that I use here and the next parts are inspired by IntelliJ IDEA.
* I will use `matvey` as a namespace for configs, you can replace it with your preferred word or nickname.

## Prerequisites
* Basic Vim knowledge
* Neovim installed: `brew install neovim`

## Neovim configs

Neovim looks for configurations in `~/.config/nvim`. Let's create this directory:
```shell
mkdir -p ~/.config/nvim
cd ~/.config/nvim
```
The file Neovim will look for is `init.lua`, let's go ahead and create it with Neovim:
```shell
nvim init.lua
```
Neovim opens new empty file.

Let's change colorscheme. Enter insert mode (`i`) and put the following line:
```lua
vim.cmd.colorscheme 'habamax'
```
This line sets colorscheme to a builtin one called `habamax`. Exit insert mode (`Esc`), then write changes (`:w`) and exit Neovim (`:q`). Now re-enter Neovim (`nvim init.lua`) to see that the colorscheme changed meaning that config works.

*To reset Neovim configs to default at any time, just remove `~/.config/nvim/init.lua` or clean the whole `~/.config/nvim/` directory.*

## Map leader and first keymap

Let's create a keymap that will write to file on hitting `Space` followed by `w`. First, let's set `Space` as a map leader. Map leader is a key that many of your custom keymaps will start with. To set map leader to `Space`, go to insert mode (`i`) and put the following lines:
```lua
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
```
Now put the following line to add the actual keymap:
```lua
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Write' })
```
* `n` means that keymap applies to normal mode
* `<leader>w` means that to activate keymap you need to enter map leader i.e. `Space` followed by `w`
* `:w<CR>` means that after you entered `<leader>w`, Neovim will go to command mode (`:`), enter Write command (`w`) and run it by hitting `Enter` (`<CR>`)

Before this keymap is applied, you need to exit insert mode (`Esc`) and write changes as usual (`:w`). But you don't actually need to re-open Neovim to apply config changes. You just need to source current file by running `:so` command. Now you can use `<Space>w` to save changes in normal mode.

## Configure Netrw

Let's now add more configs but in several separate files. First, enter the Neovim's builtin file browser called Netrw by running `:Lexplore` command or just `:Lex`. It will open Netrw in a split view on the left. First, create a new directory by hitting `d`. Enter name for new directory: `lua`. Enter it and create another directory inside (`d`), call it `matvey`. Enter it and create a new file (`%`), call it `netrw.lua`. The new empty file will open on the right. Put the following Netrw configs:
```lua
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20
```
The first line removes banner on the top of Netrw. The second line makes Netrw occupy 20% of space instead of 50% as does now. Also, let's add a keymap that will toggle Netrw on `<Space>1`, analogous to how `Cmd`+`1` toggles Project view in IntelliJ. 
```
vim.keymap.set('n', '<leader>1', vim.cmd.Lex, { desc = ‘Toggle file explorer' })
```
* `n` means it applies to normal mode
* `<leader>1` means it gets activated on `Space` followed by `1`
* `vim.cmd.Lex` means it executes `:Lex` command

But before trying these configs in action, you need to import them. First, jump back to Netrw (`<Control-w><Control-w>` i.e. hold `Control` and click `w` twice). Create a new file in `lua/matvey`, the same directory you put `netrw.lua`, call the file `init.lua`. Add the following line:
```lua
require('matvey.netrw')
```
This means we import config file `lua/matvey/netrw.lua`. But there’s one more thing to do: current file itself is not yet imported. To import it, you need to add import to the main config up in `~/.config/nvim/init.lua`. Jump back to Netrw (`<Control-w><Control-w>`), go up two levels (hit `-` to go up), enter `~/.config/nvim/init.lua` where you put your first configs. Add the following line:
```lua
require('matvey')
```
So now, when you enter Neovim the next time, it will apply configs in `~/.config/nvim/init.lua`, then it will go to `lua/matvey` directory (because of `require('matvey')` import), find `init.lua`, find that there’s another import (`require('matvey.netrw')`), open that file and apply configs there.

Re-open Neovim to try. After re-opening, hit `<Space>1` to open Netrw. Note that now it occupies less space and the banner is gone.

## Configure options

Let’s configure some Neovim options the same way you configured Netrw. Go to `lua/matvey` directory, create file (`%`) with name `options.lua`. The following line makes Neovim show line numbers:
```lua
vim.wo.number = true
```
Source file (`:so`) to apply config right away.

The next line makes line numbers relative to current line (helps for vertical navigation):
```lua
vim.o.relativenumber = true
```
Default Neovim indentation is 8 for some reason. Here are the configs to make it 2:
```lua
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.o.breakindent = true
```
By default, long lines get wrapped. To disable that, add the following line:
```lua
vim.opt.wrap = false
```
The next line will keep some space when scrolling up or down, you can try that on some larger file:
```lua
vim.opt.scrolloff = 8
```
Don’t forget that you need to import this config file. Go to Netrw, open `lua/matvey/init.lua` and add `require('matvey.options')`

## More keymaps

Let’s create one more config file where you’ll put your keymaps. Go to `lua/matvey`, create file called `keymaps.lua`.

Currently, in order to jump between windows you need to enter `<Control-w><Control-w>`. That’s a bit too long, you can shorten it to `Control` plus direction where you want to jump (`h`, `j`, `k`, `l`) with the following lines:
```lua
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Go to right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Go to down window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Go to up window' })
```
Source file, then try horizontal jumps between file and Netrw. To try vertical jumps, create a horizontal split by running `:split` command.

Having multiple windows open, you might want to resize them. Currently, the process is quite cumbersome: you need to enter `<Control-w>` followed by `+`, `-`, `<`, or `>` to change size by one unit. You can do something like `<Control-w>8+` to increase window height by 8 units, but that’s still quite inconvenient. To resize windows with `<Space>` followed by arrow key, add the following lines:
```lua
vim.keymap.set('n', '<leader><right>', '<C-w>6>', { desc = '[+] Window width' })
vim.keymap.set('n', '<leader><left>', '<C-w>6<', { desc = '[-] Window width' })
vim.keymap.set('n', '<leader><up>', '<C-w>4+', { desc = '[+] Window height' })
vim.keymap.set('n', '<leader><down>', '<C-w>4-', { desc = '[-] Window height' })
```
Source file and try resizing windows.

Quite often it can be useful to select one or several lines and move them up or down. Here are the keymaps that allow you to move selected lines with `J` and `K` (meaning `<Shift-j>` and `<Shift-k>`):
```
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
```
Note `v` that makes keymaps apply in Visual mode. Source file and try moving lines in the current file (select line with `<Shift-v>` and move it with `<Shift-j>` and `<Shift-k>`).

Don’t forget to import this configs file: go to `lua/matvey/init.lua` and add `require('matvey.keymaps')`.

You previously put your first keymap in the main config file. Now that you have a dedicated file for keymaps, let’s move it there. Go to `~/.config/nvim/init.lua` and select keymaps for writing to file. You’re going to copy this line and paste it in different file, therefore copying it with `y` will not work for now. You need to copy it to the OS clipboard by entering `"+y`, then go to `lua/matvey/keymaps.lua` and paste with `<Control-v>` or `p`. But there’s a way to avoid that. If you go to `lua/matvey/options.lua` and add the following line, you’ll synchronize Neovim clipboard with OS clipboard:
```
vim.o.clipboard = 'unnamedplus'
```
Now you can copy text in Neovim with `y` and paste it in other files in Neovim with `p` or paste anywhere with `<Command-v>`. Or you can copy text from anywhere with `<Command-c>` and paste it in Neovim with `p`.

By the way, while you're in `options.lua`, you can add one more option to allow mouse in Neovim:
```lua
vim.o.mouse = 'a'
```
This way, for example, you can resize windows using your mouse as well.

Here are a few more keymaps that you might find useful:
```
vim.keymap.set('n', '<leader>q', ':bd<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>Q', ':qa!<CR>', { desc = 'Quit' })
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
```
The first one closes current buffer with `<Space>q`. The second one quits Neovim without saving changes with `<Space>Q`. The third one makes Neovim not doing anything on single `<Space>` key.

In the next part, you will install package manager and start installing useful plugins with it.