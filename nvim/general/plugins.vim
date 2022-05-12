call plug#begin('~/.config/nvim/autoload/plugged/')

" Auto unhighlight search
Plug 'romainl/vim-cool'
" Better buffer closing
Plug 'moll/vim-bbye'
" Better code navigation
Plug 'tpope/vim-repeat'
Plug 'ggandor/lightspeed.nvim'
" Better comment keybind
Plug 'tpope/vim-commentary'
" Better indentation marker
Plug 'lukas-reineke/indent-blankline.nvim'
" Better scrolling
Plug 'karb94/neoscroll.nvim'
" Better quotation keybind
Plug 'tpope/vim-surround'
" Bufferline
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
" Code interface highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Coloring gui
Plug 'norcalli/nvim-colorizer.lua'
" File explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
" Git integration
Plug 'lewis6991/gitsigns.nvim'
" LSP and Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Remove trailing whitespace
Plug 'McAuleyPenney/tidy.nvim'
" Status line
Plug 'nvim-lualine/lualine.nvim'
" Terminal emulator
Plug 'akinsho/toggleterm.nvim'

call plug#end()
