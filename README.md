# Apéritif

## Neovim

Install Neovim:
```shell
brew install neovim
```

Copy configs:
```shell
cp -r Nvim/* ~/.config/nvim
```

Update Aperitif:
```shell
cp -r ~/.config/nvim Nvim
```

### Homebrew
```shell
cd Homebrew
chmod +x brew_install.sh
./brew_install.sh
```

### Vim
```shell
cp Vim/config.vim ~/.vimrc
git clone https://github.com/rust-lang/rust.vim ~/.vim/pack/plugins/start/rust.vim
```
