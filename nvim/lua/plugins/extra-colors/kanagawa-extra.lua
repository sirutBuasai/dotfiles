vim.api.nvim_set_hl(0, "PounceMatch", {
  bold = true,
  fg = "#adadad",
  bg = "#555555",
})

vim.api.nvim_set_hl(0, "PounceGap", {
  bold = true,
  fg = "#adadad",
  bg = "#444444",
})

vim.api.nvim_set_hl(0, "PounceAccept", {
  bold = true,
  fg = "#111111",
  bg = "#ff69a2",
})

vim.api.nvim_set_hl(0, "PounceAcceptBest", {
  bold = true,
  fg = "#111111",
  bg = "#fcba03",
})

vim.api.nvim_set_hl(0, "PounceCursorAccept", {
  bold = true,
  fg = "#111111",
  bg = "#ff69a2",
})

vim.api.nvim_set_hl(0, "PounceCursorAcceptBest", {
  bold = true,
  fg = "#111111",
  bg = "#fcba03",
})

require("lualine").setup({ options = { theme = "nightfly" } })
