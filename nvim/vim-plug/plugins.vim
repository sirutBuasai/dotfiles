call plug#begin('~/.config/nvim/autoload/plugged/')

" Add plugins here
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'unblevable/quick-scope'
Plug 'tpope/vim-commentary'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'akinsho/toggleterm.nvim'

call plug#end()
