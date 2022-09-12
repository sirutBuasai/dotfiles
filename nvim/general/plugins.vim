call plug#begin('~/.config/nvim/autoload/plugged/')

" Autocompletion
Plug 'hrsh7th/nvim-cmp'           " the completion plugin
Plug 'hrsh7th/cmp-buffer'         " buffer completions
Plug 'hrsh7th/cmp-path'           " path completions
Plug 'hrsh7th/cmp-cmdline'        " cmdline completions
Plug 'saadparwaiz1/cmp_luasnip'   " snippet completions
Plug 'hrsh7th/cmp-nvim-lsp'       " lsp completions

" Auto unhighlight search
Plug 'romainl/vim-cool'

" Better buffer closing
Plug 'moll/vim-bbye'

" Better buffer switching
Plug 'ghillb/cybu.nvim'

" Better code navigation
Plug 'tpope/vim-repeat'
Plug 'phaazon/hop.nvim'

" Better comment keybind and QoL
Plug 'numToStr/Comment.nvim'
Plug 'folke/todo-comments.nvim'

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
Plug 'nvim-treesitter/nvim-treesitter-context'

" Coloring gui
Plug 'NvChad/nvim-colorizer.lua'

" Colorscheme
Plug 'sirutBuasai/molokai.nvim'
Plug 'sirutBuasai/oxocarbon-lua.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'shaunsingh/moonlight.nvim'
Plug 'olimorris/onedarkpro.nvim'
Plug 'catppuccin/nvim'
Plug 'FrenzyExists/aquarium-vim'
Plug 'tiagovla/tokyodark.nvim'

" Errors diagnostics
Plug 'folke/trouble.nvim'

" File explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Formatting and Linting
Plug 'jose-elias-alvarez/null-ls.nvim'

" Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Git integration
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'

" Lazy-loading
Plug 'lewis6991/impatient.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'tamago324/nlsp-settings.nvim'
Plug 'stevearc/aerial.nvim'

" Remove trailing whitespace
Plug 'mcauley-penney/tidy.nvim'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" Status line
Plug 'nvim-lualine/lualine.nvim'

" Startup dashboard
Plug 'goolord/alpha-nvim'

" Terminal emulator
Plug 'akinsho/toggleterm.nvim'

" UI and visual QOL
Plug 'stevearc/dressing.nvim'
Plug 'winston0410/cmd-parser.nvim'
Plug 'winston0410/range-highlight.nvim'

" Zenmode
Plug 'folke/zen-mode.nvim'

call plug#end()
