return {
  config = {
    toggles = {
      dim = true,
      git_signs = false,
      mini_diff_signs = false,
      diagnostics = false,
      inlay_hints = false,
      line_number = false,
      relative_number = false,
      signcolumn = "no",
      indent = false,
    },
    show = {
      statusline = false, -- can only be shown when using the global statusline
      tabline = false,
    },
    win = {
      width = 0,
      height = 0,
      backdrop = { transparent = false, blend = 75 },
    },
  },
}
