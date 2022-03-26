call plug#begin('~/.config/nvim/autoload/plugged/')

" Add plugins here
Plug 'VundleVim/Vundle.vim'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'unblevable/quick-scope'

call plug#end()

