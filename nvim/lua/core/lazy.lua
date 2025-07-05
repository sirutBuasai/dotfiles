-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

local plugins = {
  -- Autocompletion
  { "rafamadriz/friendly-snippets", lazy = false },
  { "xzbdmw/colorful-menu.nvim", lazy = false },
  {
    "saghen/blink.cmp",
    version = "*",
    lazy = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "echasnovski/mini.icons",
    },
  },

  -- Better buffer closing
  { "moll/vim-bbye", lazy = false },

  -- Better buffer switching
  { "ghillb/cybu.nvim", lazy = true },

  -- Better code navigation
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
    lazy = true,
    event = "InsertEnter",
  },

  -- Better search
  { "romainl/vim-cool", lazy = false },

  -- Better quotation keybind
  { "echasnovski/mini.surround", lazy = false },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    version = "*",
    dependencies = { "echasnovski/mini.icons" },
  },

  -- Coloring gui
  { "NvChad/nvim-colorizer.lua", lazy = false },

  -- Colorscheme
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 25000,
    config = function()
      require("plugins.extra-colors.kanagawa-extra")
      vim.cmd("colorscheme kanagawa-wave")
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "echasnovski/mini.icons" },
  },

  -- Fuzzy finder
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    dependencies = { "echasnovski/mini.icons" },
  },

  -- Icons
  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
    specs = {
      {
        "nvim-tree/nvim-web-devicons",
        enabled = false,
        optional = true,
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- Git integration
  { "lewis6991/gitsigns.nvim", lazy = false },
  { "sindrets/diffview.nvim", lazy = true },

  -- LSP
  { "mason-org/mason.nvim", lazy = false },
  { "mason-org/mason-lspconfig.nvim", lazy = false },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", lazy = false },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
  },
  { "stevearc/conform.nvim", lazy = false },

  -- Markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons"
    },
  },

  -- Remove trailing whitespace
  { "mcauley-penney/tidy.nvim", lazy = true },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "echasnovski/mini.icons" },
  },

  -- Startup dashboard
  {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = { "echasnovski/mini.icons" },
  },

  -- Treesitter
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
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- UI
  {
    "winston0410/range-highlight.nvim",
    lazy = true,
    event = { "CmdlineEnter" },
  },

  -- Other Colorcheme
  -- { "sirutBuasai/molokai", lazy = false },
  -- { "olimorris/onedarkpro.nvim", lazy = false },
  -- { "catppuccin/nvim", lazy = false },
  -- { "tiagovla/tokyodark.nvim", lazy = false },
  -- {
  --   "nyoom-engineering/oxocarbon.nvim",
  --   lazy = false,
  --   priority = 25000,
  --   config = function()
  --     vim.opt.background = "dark"
  --     vim.cmd("colorscheme oxocarbon")
  --     require("plugins.extra-colors.oxocarbon-extra")
  --   end,
  -- },
}

local opts = {
  install = { colorscheme = { "kanagawa" } },
  checker = { enabled = true },
}

lazy.setup(plugins, opts)
