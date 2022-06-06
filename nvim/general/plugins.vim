call plug#begin('~/.config/nvim/autoload/plugged/')

" Autocompletion
Plug 'hrsh7th/nvim-cmp'           " The completion plugin
Plug 'hrsh7th/cmp-buffer'         " buffer completions
Plug 'hrsh7th/cmp-path'           " path completions
Plug 'hrsh7th/cmp-cmdline'        " cmdline completions
Plug 'saadparwaiz1/cmp_luasnip'   " snippet completions

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

" Better parentheses pairing
Plug 'windwp/nvim-autopairs'

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

" Errors diagnostics
Plug 'folke/trouble.nvim'

" File explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Formatting and Linting
Plug 'jose-elias-alvarez/null-ls.nvim'

" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

" Git integration
Plug 'lewis6991/gitsigns.nvim'

" LSP
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'tamago324/nlsp-settings.nvim'

" LSP UI
Plug 'stevearc/dressing.nvim'

" Remove trailing whitespace
Plug 'McAuleyPenney/tidy.nvim'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" Status line
Plug 'nvim-lualine/lualine.nvim'

" Terminal emulator
Plug 'akinsho/toggleterm.nvim'

" Colorscheme
Plug 'sirutBuasai/molokai.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'shaunsingh/moonlight.nvim'
Plug 'olimorris/onedarkpro.nvim'
Plug 'catppuccin/nvim'
Plug 'FrenzyExists/aquarium-vim'
Plug 'tiagovla/tokyodark.nvim'

call plug#end()
