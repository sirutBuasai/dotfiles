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
