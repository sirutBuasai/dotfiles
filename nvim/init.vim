" Local files setup ------------------------------------------------------------------------------
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/mappings.vim
source $HOME/.config/nvim/general/colorscheme.vim
source $HOME/.config/nvim/general/plugins.vim
" Vimscript plugins
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/telescope.vim
source $HOME/.config/nvim/plug-config/nvim-tree.vim
source $HOME/.config/nvim/plug-config/bbye.vim
" Lua files setup --------------------------------------------------------------------------------
" Lua plugins
lua require("plug-config.indent-blankline")
lua require("plug-config.treesetter")
lua require("plug-config.toggleterm")
lua require("plug-config.nvim-tree")
lua require("plug-config.bufferline")
lua require("plug-config.colorizer")
lua require("plug-config.neoscroll")
