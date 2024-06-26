local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim....")

  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

local plugins = {
  -- Autocompletion
  { "hrsh7th/nvim-cmp", lazy = false }, -- the completion plugin
  { "hrsh7th/cmp-buffer", lazy = false }, -- buffer completions
  { "hrsh7th/cmp-path", lazy = false }, -- path completions
  { "hrsh7th/cmp-cmdline", lazy = false }, -- cmdline completions
  { "saadparwaiz1/cmp_luasnip", lazy = false }, -- snippet completions
  { "hrsh7th/cmp-nvim-lsp", lazy = false }, -- lsp completions

  -- Better annotation and docstring
  { "danymat/neogen", lazy = true },

  -- Better buffer closing
  { "moll/vim-bbye", lazy = false },

  -- Better buffer switching
  { "ghillb/cybu.nvim", lazy = true },

  -- Better code navigation
  { "tpope/vim-repeat", lazy = true },
  { "rlane/pounce.nvim", lazy = true },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    build = "./kitty/install-kittens.bash",
  },

  -- Better comment
  { "numToStr/Comment.nvim", lazy = true },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Better highlighting
  { "m-demare/hlargs.nvim", lazy = false },
  { "RRethy/vim-illuminate", lazy = false },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    priority = 1,
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context", lazy = false },
  { "tzachar/highlight-undo.nvim", lazy = false },

  -- Better indentation marker
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = false,
  },

  -- Better parentheses pairing
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
  },

  -- Better search
  { "romainl/vim-cool", lazy = false },

  -- Better quotation keybind
  { "kylechui/nvim-surround", lazy = true },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Coloring gui
  { "NvChad/nvim-colorizer.lua", lazy = false },

  -- Colorscheme
  { "sirutBuasai/molokai", lazy = false },
  { "olimorris/onedarkpro.nvim", lazy = false },
  { "catppuccin/nvim", lazy = false },
  { "tiagovla/tokyodark.nvim", lazy = false },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    -- priority = 25000,
    -- config = function()
    --   vim.opt.background = "dark"
    --   vim.cmd("colorscheme oxocarbon")
    --   require("plugins.extra-colors.oxocarbon-extra")
    -- end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 25000,
    config = function()
      vim.cmd("colorscheme kanagawa")
      require("plugins.extra-colors.kanagawa-extra")
    end,
  },

  -- File explorer
  { "nvim-tree/nvim-web-devicons", lazy = false },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Folding
  {
    "kevinhwang91/nvim-ufo",
    lazy = false,
    dependencies = { "kevinhwang91/promise-async" },
  },

  -- Fuzzy finder
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = false,
    build = "make",
  },

  -- Git integration
  { "lewis6991/gitsigns.nvim", lazy = false },
  { "sindrets/diffview.nvim", lazy = true },

  -- LSP
  { "neovim/nvim-lspconfig", lazy = false },
  { "williamboman/mason.nvim", lazy = false },
  { "williamboman/mason-lspconfig.nvim", lazy = false },
  { "tamago324/nlsp-settings.nvim", lazy = false },
  { "stevearc/aerial.nvim", lazy = true },
  { "stevearc/conform.nvim", lazy = false },

  -- Markdown
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
  },

  -- Remove trailing whitespace
  { "mcauley-penney/tidy.nvim", lazy = true },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    lazy = true,
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  { "rafamadriz/friendly-snippets", lazy = true },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Startup dashboard
  {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Terminal emulator
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    version = "*",
  },

  -- UI
  { "stevearc/dressing.nvim", lazy = false },
  {
    "winston0410/range-highlight.nvim",
    lazy = false,
    dependencies = { "winston0410/cmd-parser.nvim" },
  },
  { "winston0410/cmd-parser.nvim", lazy = true },

  -- Zenmode
  { "folke/zen-mode.nvim", lazy = true },
}

local opts = {}

lazy.setup(plugins, opts)
