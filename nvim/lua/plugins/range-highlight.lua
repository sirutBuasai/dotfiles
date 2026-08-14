-- plugins/range-highlight.lua — highlight the line range an ex-command will affect.
--
-- e.g. typing :10,20d highlights lines 10-20 live. Needs cmd-parser to
-- understand the range portion of the command line.

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
