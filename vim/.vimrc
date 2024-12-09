" --- PLUGINS ---

call plug#begin('~/.vim/plugged')

call plug#end()

 " --- CONFIG ---

filetype on

filetype plugin on
filetype indent on

syntax on

set number

"set cursorline

"set cursorcolumn

set tabstop=4 "Tab width

set nobackup

set nowrap

set incsearch "highlight matching characters search

set ignorecase "ignore capital letters during search

set termguicolors

colorscheme darcula
