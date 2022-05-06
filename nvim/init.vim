" Local files setup
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/mappings.vim
source $HOME/.config/nvim/general/colorscheme.vim
source $HOME/.config/nvim/general/plugins.vim
" Vimscript plugins
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/bbye.vim
" Lua plugins
lua require("plug-config.bufferline")
lua require("plug-config.colorizer")
lua require("plug-config.gitsigns")
lua require("plug-config.indent-blankline")
lua require("plug-config.lightspeed")
lua require("plug-config.lualine")
lua require("plug-config.neoscroll")
lua require("plug-config.nvim-tree")
lua require("plug-config.telescope")
lua require("plug-config.toggleterm")
lua require("plug-config.treesetter")
