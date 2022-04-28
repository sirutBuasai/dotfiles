" Local files setup ------------------------------------------------------------------------------
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/mappings.vim
source $HOME/.config/nvim/general/colorscheme.vim
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/telescope.vim
lua require("plug-config.indent-blankline")
lua require("plug-config.treesetter")
lua require("plug-config.toggleterm")
