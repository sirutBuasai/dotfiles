local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local icons = require("user.icons")

local tree_cb = nvim_tree_config.nvim_tree_callback

local modes = { 'n' }

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  open_on_setup_file = false,
  ignore_ft_on_setup = {},
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = icons.diagnostics.Hint,
      info = icons.diagnostics.Info,
      warning = icons.diagnostics.Warning,
      error = icons.diagnostics.Error,
    },
  },
  renderer = {
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = icons.documents.File,
        symlink = icons.documents.SymlinkFile,
        folder = {
          arrow_closed = icons.ui.ArrowClosed,
          arrow_open = icons.ui.ArrowOpen,
          default = icons.documents.Folder,
          open = icons.documents.OpenFolder,
          empty = icons.documents.EmptyFolder,
          empty_open = icons.documents.OpenEmptyFolder,
          symlink = icons.documents.SymlinkFolder,
        },
        git = {
          unstaged = icons.git.Unstaged,
          staged = icons.git.Staged,
          unmerged = icons.git.Unmerged,
          renamed = icons.git.Renamed,
          deleted = icons.git.Remove,
          untracked = icons.git.Untracked,
          ignored = icons.git.Ignored,
        },
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  view = {
    width = 35,
    side = "left",
    preserve_window_proportions = false,
    mappings = {
      custom_only = false,
      list = {
        { key = { "<CR>" }, action = "edit" },
        { key = "+", action = "cd" },
        { key = "o", action = "close" },
        { key = "v", cb = tree_cb "vsplit" },
        { key = "h", cb = tree_cb "split" },
        { key = "f", action = ""},
        { key = "F", action = ""},
      },
    },
    number = false,
    relativenumber = false,
  },
  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = true,
    },
  },
})

vim.keymap.set(modes, '<leader>t', ':NvimTreeToggle<CR>', { noremap = true })
