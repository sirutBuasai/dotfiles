local icons = require("config.icons")

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    -- disable snacks animations
    vim.g.snacks_animate = false
  end,
  ---@type snacks.Config
  opts = {
    -- enabled modules
    words = { enabled = true },
    indent = { enabled = true },
    bufdelete = { enabled = true },
    gitbrowse = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },

    -- disabled modules
    statuscolumn = { enabled = false },
    scroll = { enabled = false },
    zen = { enabled = false },
    bigfile = { enabled = false },
    explorer = { enabled = false },
    scratch = { enabled = false },
    toggle = { enabled = false },
    image = { enabled = false },
    scope = { enabled = false },

    -- picker
    picker = {
      matcher = { frecency = true },
      win = {
        input = {
          keys = {
            ["<S-Down>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<S-Up>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<S-Left>"] = { "preview_scroll_left", mode = { "i", "n" } },
            ["<S-Right>"] = { "preview_scroll_right", mode = { "i", "n" } },
          },
        },
      },
      formatters = {
        file = { filename_first = true, truncate = 80 },
      },
    },

    -- notifier
    notifier = {
      level = vim.log.levels.INFO,
      icons = {
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warning,
        info = icons.diagnostics.Info,
        debug = icons.diagnostics.Debug,
        trace = icons.diagnostics.Trace,
      },
    },

    -- input
    input = { icon = icons.ui.Pencil },

    -- window styles
    styles = {
      input = { relative = "cursor", row = -3, col = 0 },
      notification = { wo = { wrap = true } },
    },

    -- dashboard
    dashboard = {
      enabled = true,
      sections = {
        {
          pane = 1,
          section = "header",
          height = 5,
          padding = 1,
        },
        { pane = 1, section = "keys", indent = 2, gap = 1, padding = 1 },
        {
          pane = 2,
          section = "terminal",
          cmd = "colorscript -e square",
          height = 5,
          padding = 2,
        },
        { pane = 2, icon = icons.ui.NewFile, title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = icons.documents.OpenFolder,
          title = "Projects",
          section = "projects",
          indent = 2,
          padding = 1,
        },
        {
          pane = 2,
          icon = icons.git.Branch,
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
      preset = {
        keys = {
          { icon = icons.dashboard.Folder, key = "o", desc = "  Open tree", action = ":NvimTreeToggle" },
          { icon = icons.dashboard.Find, key = "f", desc = "  Find file", action = ":lua Snacks.picker.files()" },
          { icon = icons.dashboard.Time, key = "r", desc = "  Recently used files", action = ":lua Snacks.picker.recent({ filter = { cwd = true }})" },
          { icon = icons.dashboard.Text, key = "g", desc = "  Find text", action = ":lua Snacks.picker.grep()" },
          { icon = icons.dashboard.Notes, key = "n", desc = "  Obsidian Vault", action = ":e $HOME/obsidian_vault/" },
          { icon = icons.dashboard.Setting, key = "c", desc = "  Neovim Configuration", action = ":e $HOME/.config/nvim/" },
          { icon = icons.dashboard.Shell, key = "t", desc = "  Ghostty Configuration", action = ":e $HOME/.config/ghostty/" },
          { icon = icons.dashboard.Shell, key = "z", desc = "  Shell Configuration", action = ":e $HOME/.zshrc" },
          { icon = icons.dashboard.Close, key = "q", desc = "  Close Dashboard", action = ":q" },
          { icon = icons.dashboard.Quit, key = "Q", desc = "  Quit Neovim", action = ":qa" },
        },
      },
    },
  },

  -- keymaps
  keys = {
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
    {
      "<C-w>",
      function()
        -- count non-floating windows in the current tab
        local wins = vim.tbl_filter(function(w)
          return vim.api.nvim_win_get_config(w).relative == ""
        end, vim.api.nvim_tabpage_list_wins(0))
        if #wins > 1 then
          vim.cmd("close") -- a split is open → close just this split
          return
        end
        -- sole window: delete the buffer (or quit on the last one)
        local listed = vim.tbl_filter(function(b)
          return vim.bo[b].buflisted
        end, vim.api.nvim_list_bufs())
        if #listed > 1 then
          Snacks.bufdelete()
        else
          vim.cmd("quit")
        end
      end,
      desc = "Close split (or delete buffer / quit if last)",
    },

    { "<leader>ghb", function() Snacks.gitbrowse() end, desc = "Git browse (open in web)", mode = { "n", "v" } },
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification history" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },

    -- pickers keymaps
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
    { "<leader>fb", function() Snacks.picker.grep_buffers() end, desc = "Grep open buffers" },
    { "<leader>fB", function() Snacks.picker.buffers() end, desc = "List buffers" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Live grep" },
    { "<leader>fr", function() Snacks.picker.recent({ filter = { cwd = true } }) end, desc = "Recent files (cwd)" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Search keymaps" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Search help tags" },

    -- git keymaps
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git stash" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git diff (hunks)" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git log" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git log (this file)" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git log (this line)" },
  },
}
