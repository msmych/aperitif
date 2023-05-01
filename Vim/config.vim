set nocompatible

syntax enable
syntax on

filetype plugin on
filetype indent on

set path+=**

set history=200
set ruler
set showcmd
set wildmenu

set scrolloff=5

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3 	" Tree style
let g:netrw_altv = 1 		" Open file on the right
let g:netrw_winsize = 20

" Rust
let g:rustfmt_autosave = 1
