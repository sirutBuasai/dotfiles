call plug#begin('~/.config/nvim/autoload/plugged/')

" Status line
Plug 'bling/vim-airline'
" Code interface highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" LSP and Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Better comment keybind
Plug 'tpope/vim-commentary'
" Better quotation keybind
Plug 'tpope/vim-surround'
" Better indentation marker
Plug 'lukas-reineke/indent-blankline.nvim'
" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
" Terminal emulator
Plug 'akinsho/toggleterm.nvim'

call plug#end()
