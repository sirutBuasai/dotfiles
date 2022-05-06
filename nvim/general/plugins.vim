call plug#begin('~/.config/nvim/autoload/plugged/')

" Status line
Plug 'nvim-lualine/lualine.nvim'
" Code interface highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" LSP and Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Better scrolling
Plug 'karb94/neoscroll.nvim'
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
" File explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
" Bufferline
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
" Better buffer closing
Plug 'moll/vim-bbye'
" Coloring gui
Plug 'norcalli/nvim-colorizer.lua'
" Sneak for code navigation
Plug 'justinmk/vim-sneak'

call plug#end()
