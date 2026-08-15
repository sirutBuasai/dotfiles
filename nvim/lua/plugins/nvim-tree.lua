return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = { "echasnovski/mini.icons" },
  keys = { { "<leader>t", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" } },
  config = function()
    local icons = require("config.icons")
    local api = require("nvim-tree.api")

    local on_attach = function(bufnr)
      local opts = function(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- root / directory navigation
      vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
      vim.keymap.set("n", "+", api.tree.change_root_to_node, opts("CD"))
      vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
      vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
      vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))

      -- open
      vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
      vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
      vim.keymap.set("n", "h", api.node.open.horizontal, opts("Open: Horizontal Split"))
      vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
      vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))

      -- file operations
      vim.keymap.set("n", "a", api.fs.create, opts("Create"))
      vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
      vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
      vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
      vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
      vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
      vim.keymap.set("n", "<leader>rn", api.fs.rename, opts("Rename"))
      vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
      vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
      vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))

      -- filters / view
      vim.keymap.set("n", "H", api.filter.dotfiles.toggle, opts("Toggle Dotfiles"))
      vim.keymap.set("n", "I", api.filter.git.ignored.toggle, opts("Toggle Git Ignore"))
      vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
      vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
      vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
      vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
      vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))

      -- git / diagnostics navigation
      vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
      vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
      vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
      vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))

      -- bookmarks
      vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
      vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))

      -- close
      vim.keymap.set("n", "o", api.tree.close, opts("Close"))
      vim.keymap.set("n", "q", api.tree.close, opts("Close")) -- also closes from the dashboard

      -- free f/F for pounce inside the tree
      vim.keymap.set("n", "F", "", { buffer = bufnr })
      vim.keymap.del("n", "F", { buffer = bufnr })
      vim.keymap.set("n", "f", "", { buffer = bufnr })
      vim.keymap.del("n", "f", { buffer = bufnr })
    end

    require("nvim-tree").setup({
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = false,
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
        group_empty = true, -- collapse single-child dir chains onto one line
        icons = {
          git_placement = "before",
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
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
    })
  end,
}
