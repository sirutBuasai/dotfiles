local status_ok, cybu = pcall(require, "cybu")
if not status_ok then
  return
end

cybu.setup {
  position = {
    relative_to = "editor",       -- win, editor, cursor
    anchor = "center",            -- topleft, topcenter, topright,
                                  -- centerleft, center, centerright,
                                  -- bottomleft, bottomcenter, bottomright
    vertical_offset = 0,          -- vertical offset from anchor in lines
    horizontal_offset = 0,        -- vertical offset from anchor in columns
    max_win_height = 5,           -- height of cybu window in lines
    max_win_width = 0.5,          -- integer for absolute in columns
                                  -- float for relative to win/editor width
  },
  style = {
    path = "relative",            -- absolute, relative, tail (filename only)
    border = "rounded",           -- single, double, rounded, none
    separator = " ",              -- string used as separator
    prefix = "…",                 -- string used as prefix for truncated paths
    padding = 1,                  -- left & right padding in number of spaces
    hide_buffer_id = true,        -- hide buffer IDs in window
    devicons = {
      enabled = true,             -- enable or disable web dev icons
      colored = true,             -- enable color for web dev icons
      truncate = false,           -- truncate wide icons to one char width
    },
    highlights = {                -- see highlights via :highlight
      current_buffer = "CybuFocus",       -- current / selected buffer
      adjacent_buffers = "CybuAdjacent",  -- buffers not in focus
      background = "CybuBackground",      -- window background
      border = "CybuBorder",              -- border of the window
    },
  },
  behavior = {                    -- set behavior for different modes
    mode = {
      default = {
        switch = "immediate",     -- immediate, on_close
        view = "paging",          -- paging, rolling
      },
      last_used = {
        switch = "immediate",     -- immediate, on_close
        view = "paging",          -- paging, rolling
      },
    },
  },
  display_time = 1500,            -- time the cybu window is displayed
}

vim.keymap.set("n", "<C-S-n>", "<Plug>(CybuLastusedNext)")
vim.keymap.set("n", "<C-S-b>", "<Plug>(CybuLastusedPrev)")
vim.keymap.set("n", "<C-n>", "<Plug>(CybuNext)")
vim.keymap.set("n", "<C-b>", "<Plug>(CybuPrev)")
