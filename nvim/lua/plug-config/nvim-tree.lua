local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {},
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
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
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
        git = {
          unstaged = "",
          staged = "",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
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
    width = 30,
    height = 30,
    side = "left",
    preserve_window_proportions = false,
    mappings = {
      custom_only = false,
      list = {
        { key = { "<CR>" }, cb = tree_cb "edit" },
        { key = "+", cb = tree_cb "cd" },
        { key = "c", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
        { key = "h", cb = tree_cb "split" },
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

vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<CR>', { noremap = true })
