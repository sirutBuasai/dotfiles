local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local modes = { "n" }

local icons = require("user.icons")

local api = require("nvim-tree.api")

local on_attach = function(bufnr)
  local opts = function(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set(modes, "<C-]>", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set(modes, "<C-=>", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set(modes, "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
  vim.keymap.set(modes, "<C-k>", api.node.show_info_popup, opts("Info"))
  vim.keymap.set(modes, "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
  vim.keymap.set(modes, "<C-t>", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set(modes, "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set(modes, "v", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set(modes, "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set(modes, "h", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set(modes, "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set(modes, "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set(modes, "<Tab>", api.node.open.preview, opts("Open Preview"))
  vim.keymap.set(modes, ">", api.node.navigate.sibling.next, opts("Next Sibling"))
  vim.keymap.set(modes, "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
  vim.keymap.set(modes, ".", api.node.run.cmd, opts("Run Command"))
  vim.keymap.set(modes, "<C-->", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set(modes, "a", api.fs.create, opts("Create"))
  vim.keymap.set(modes, "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
  vim.keymap.set(modes, "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
  vim.keymap.set(modes, "c", api.fs.copy.node, opts("Copy"))
  vim.keymap.set(modes, "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
  vim.keymap.set(modes, "[c", api.node.navigate.git.prev, opts("Prev Git"))
  vim.keymap.set(modes, "]c", api.node.navigate.git.next, opts("Next Git"))
  vim.keymap.set(modes, "d", api.fs.remove, opts("Delete"))
  vim.keymap.set(modes, "D", api.fs.trash, opts("Trash"))
  vim.keymap.set(modes, "E", api.tree.expand_all, opts("Expand All"))
  vim.keymap.set(modes, "e", api.fs.rename_basename, opts("Rename: Basename"))
  vim.keymap.set(modes, "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
  vim.keymap.set(modes, "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
  vim.keymap.set(modes, "F", "", { buffer = bufnr }) -- Custom delete mapping to allow pounce.nvim
  vim.keymap.del(modes, "F", { buffer = bufnr }) -- Custom delete mapping to allow pounce.nvim
  vim.keymap.set(modes, "f", "", { buffer = bufnr }) -- Custom delete mapping to allow pouncenvim
  vim.keymap.del(modes, "f", { buffer = bufnr }) -- Custom delete mapping to allow pouncenvim
  vim.keymap.set(modes, "g?", api.tree.toggle_help, opts("Help"))
  vim.keymap.set(modes, "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  vim.keymap.set(modes, "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
  vim.keymap.set(modes, "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
  vim.keymap.set(modes, "J", api.node.navigate.sibling.last, opts("Last Sibling"))
  vim.keymap.set(modes, "K", api.node.navigate.sibling.first, opts("First Sibling"))
  vim.keymap.set(modes, "m", api.marks.toggle, opts("Toggle Bookmark"))
  vim.keymap.set(modes, "o", api.tree.close, opts("Close"))
  vim.keymap.set(modes, "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
  vim.keymap.set(modes, "p", api.fs.paste, opts("Paste"))
  vim.keymap.set(modes, "P", api.node.navigate.parent, opts("Parent Directory"))
  vim.keymap.set(modes, "q", api.tree.close, opts("Close")) -- Custom close mapping to allow closing in dashboard
  vim.keymap.set(modes, "r", api.fs.rename, opts("Rename"))
  vim.keymap.set(modes, "R", api.tree.reload, opts("Refresh"))
  vim.keymap.set(modes, "s", api.node.run.system, opts("Run System"))
  vim.keymap.set(modes, "S", api.tree.search_node, opts("Search"))
  vim.keymap.set(modes, "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
  vim.keymap.set(modes, "W", api.tree.collapse_all, opts("Collapse"))
  vim.keymap.set(modes, "x", api.fs.cut, opts("Cut"))
  vim.keymap.set(modes, "y", api.fs.copy.filename, opts("Copy Name"))
  vim.keymap.set(modes, "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
  vim.keymap.set(modes, "<2-LeftMouse>", api.node.open.edit, opts("Open"))
  vim.keymap.set(modes, "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
end

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  on_attach = on_attach,
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
    ignore_list = { "toggleterm" },
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  view = {
    width = "25%",
    side = "left",
    preserve_window_proportions = false,
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

vim.keymap.set(modes, "<leader>t", ":NvimTreeToggle<CR>", { noremap = true })
