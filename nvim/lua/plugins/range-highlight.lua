return {
  {
    "winston0410/range-highlight.nvim",
    dependencies = { "winston0410/cmd-parser.nvim" },
    event = "CmdlineEnter",
    config = function()
      require("range-highlight").setup()
    end,
  },
}
