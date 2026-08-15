return {
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local icons = require("config.icons")
      local ok_kana, kana = pcall(require, "kanagawa.colors")
      local p = ok_kana and kana.setup().palette or {}
      return {
        signs = true,
        sign_priority = 8,
        keywords = {
          FIX = {
            icon = icons.ui.Bug .. " ",
            color = "error",
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "ERROR" },
            signs = true,
          },
          TODO = { icon = icons.ui.BoldCheck, color = "info", signs = true },
          HACK = { icon = icons.ui.Fire, color = "warning", signs = true },
          WARN = { icon = icons.diagnostics.FilledWarning, color = "warning", alt = { "WARNING", "XXX" }, signs = true },
          PERF = { icon = icons.ui.ClockFast, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" }, signs = true },
          NOTE = { icon = icons.ui.Comment, color = "hint", alt = { "INFO" }, signs = true },
          TEST = { icon = icons.ui.TestTube, color = "test", alt = { "TESTING", "PASSED", "FAILED" }, signs = true },
        },
        gui_style = {
          fg = "NONE",
          bg = "BOLD",
        },
        merge_keywords = true,
        highlight = {
          before = "",
          keyword = "wide",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
          max_line_len = 400,
          exclude = {},
        },
        colors = {
          error = { p.peachRed or "#FF5D62" },
          warning = { p.roninYellow or "#FF9E3B" },
          info = { p.crystalBlue or "#7E9CD8" },
          hint = { p.springGreen or "#98BB6C" },
          default = { p.oniViolet or "#957FB8" },
          test = { p.sakuraPink or "#D27E99" },
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          pattern = [[\b(KEYWORDS):]],
        },
      }
    end,
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous TODO comment" },
      { "<leader>ft", "<cmd>TodoQuickFix<CR>", desc = "Find TODOs (quickfix)" },
    },
  },
}
