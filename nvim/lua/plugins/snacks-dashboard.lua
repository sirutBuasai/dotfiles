local icons = require("config.icons")

return {
  config = {
    sections = {
      {
        pane = 1,
        section = "header",
        height = 5,
        padding = 1,
      },
      -- { pane = 1, icon = icons.ui.FilledBookMark, title = "General", section = "keys", indent = 2, gap = 0.5, padding = 1,1 },
      -- { pane = 1, icon = icons.ui.FilledBookMark, title = "General", indent = 2, gap = 1, padding = 1 },
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
        { icon = icons.dashboard.Find, key = "f", desc = "  Find file", action = ":FzfLua files" },
        { icon = icons.dashboard.Time, key = "r", desc = "  Recently used files", action = ":FzfLua oldfiles" },
        { icon = icons.dashboard.Text, key = "g", desc = "  Find text", action = ":FzfLua live_grep_glob" },
        {
          icon = icons.dashboard.Setting,
          key = "c",
          desc = "  Neovim Configuration",
          action = ":e $HOME/.config/nvim/",
        },
        {
          icon = icons.dashboard.Shell,
          key = "t",
          desc = "  Kitty Configuration",
          action = ":e $HOME/.config/kitty/",
        },
        { icon = icons.dashboard.Shell, key = "z", desc = "  Shell Configuration", action = ":e $HOME/.zshrc" },
        { icon = icons.dashboard.Close, key = "q", desc = "  Close Dashboard", action = ":q" },
        { icon = icons.dashboard.Quit, key = "Q", desc = "  Quit Neovim", action = ":qa" },
      },
    },
  },
}
