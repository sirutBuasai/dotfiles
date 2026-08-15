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
      -- skip these when cycling (default is neo-tree/fugitive/qf)
      exclude = { "NvimTree", "qf", "help", "fugitive" },
      filter = { unlisted = true },
    },
  },
}
