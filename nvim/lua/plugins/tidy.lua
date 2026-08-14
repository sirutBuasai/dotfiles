-- plugins/tidy.lua — mcauley-penney/tidy.nvim
--
-- Strips trailing whitespace + trailing blank lines at EOF on save.
-- Lightweight alternative to a hand-rolled autocmd.
--
-- filetype_exclude: tidy's default is EMPTY (trims everything), which would eat
-- markdown's intentional trailing-double-space line breaks and mangle diffs — so
-- exclude those. API if you need it: require("tidy").toggle() / .run().

return {
  {
    "mcauley-penney/tidy.nvim",
    event = { "BufWritePre" },
    config = function()
      require("tidy").setup({
        filetype_exclude = { "markdown", "diff" },
      })
    end,
  },
}
