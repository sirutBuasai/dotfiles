-- plugins/mini-surround.lua — echasnovski/mini.surround
--
-- vim-surround-style keymaps restored (your muscle memory):
--   ys = add      (e.g. ysiw"  → surround word with ")
--   ds = delete   (ds"        → remove surrounding ")
--   cs = replace  (cs"'       → change " to ')
--   ch = highlight surrounding
-- find / next / last suffixes are disabled.

return {
  {
    "echasnovski/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.surround").setup({
        highlight_duration = 500,
        mappings = {
          add = "ys",
          delete = "ds",
          replace = "cs",
          highlight = "ch",
          find = "",
          find_left = "",
          update_n_lines = "",
          suffix_last = "",
          suffix_next = "",
        },
        n_lines = 100,
        respect_selection_type = false,
        search_method = "cover_or_nearest",
        silent = true,
      })
      -- Note: `ys` is intentionally left mapped in VISUAL mode too (your
      -- preference), so visual `y` waits ~timeoutlen before yanking. Accepted
      -- tradeoff for consistent `ys` everywhere.
    end,
  },
}
