local icons = require("config.icons")

return {
  config = {
    matcher = {
      frecency = true,
    },
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
      file = {
        filename_first = true, -- display filename before the file path
        truncate = 80,
      },
    },
  },
}
