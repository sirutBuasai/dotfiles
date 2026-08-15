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
    end,
  },
}
