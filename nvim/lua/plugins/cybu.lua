-- plugins/cybu.lua — ghillb/cybu.nvim
--
-- Buffer cycling with a centered preview popup. Restored from your prior config
-- (rounded border, relative paths, colored devicons, paging view) plus the
-- last-used (MRU) cycling on <C-S-n>/<C-S-b>. Added `exclude` so cycling skips
-- NvimTree / quickfix / help instead of landing in them.
--
-- NOTE: <C-S-n>/<C-S-b> (Ctrl+Shift) need the kitty keyboard protocol to be
-- distinguishable from <C-n>/<C-b> — Ghostty provides it and tmux has
-- extended-keys on, so this works in your stack.

return {
  {
    "ghillb/cybu.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-n>", "<Plug>(CybuNext)", desc = "Next buffer" },
      { "<C-b>", "<Plug>(CybuPrev)", desc = "Previous buffer" },
      { "<C-S-n>", "<Plug>(CybuLastusedNext)", desc = "Next (last-used) buffer" },
      { "<C-S-b>", "<Plug>(CybuLastusedPrev)", desc = "Previous (last-used) buffer" },
    },
    opts = {
      position = {
        relative_to = "editor",
        anchor = "center",
        vertical_offset = 0,
        horizontal_offset = 0,
        max_win_height = 5,
        max_win_width = 0.5,
      },
      style = {
        path = "relative", -- absolute, relative, tail
        border = "rounded",
        separator = " ",
        prefix = "…",
        padding = 1,
        hide_buffer_id = true,
        devicons = {
          enabled = true,
          colored = true,
          truncate = false,
        },
        highlights = {
          current_buffer = "CybuFocus",
          adjacent_buffers = "CybuAdjacent",
          background = "CybuBackground",
          border = "CybuBorder",
        },
      },
      behavior = {
        mode = {
          default = { switch = "immediate", view = "paging" },
          last_used = { switch = "immediate", view = "paging" },
        },
      },
      display_time = 500,
      -- skip these when cycling (default is neo-tree/fugitive/qf; you use NvimTree)
      exclude = { "NvimTree", "qf", "help", "fugitive" },
      filter = { unlisted = true },
    },
  },
}
