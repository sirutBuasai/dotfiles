return {
  {
    "m-demare/hlargs.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      color = "#B2B9D7",
      hl_priority = 10000,
      extras = {
        unused_args = { link = "DiagnosticUnnecessary" },
        named_parameters = true,
      },
    },
  },
}
