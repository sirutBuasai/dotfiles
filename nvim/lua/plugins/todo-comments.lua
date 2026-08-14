-- plugins/todo-comments.lua — folke/todo-comments.nvim
--
-- Highlights TODO/FIX/HACK/WARN/PERF/NOTE/TEST in comments + sign-column icons.
-- Restored from your prior config: custom keyword icons (from config.icons),
-- extra alts, wide keyword highlight, bold bg, rg search.
-- Highlight color palettes — kanagawa's Diagnostic* groups were too muted, so
-- `colors` uses vivid hex. Inspect these and tell me which set to use (or swap
-- the active hex in the `colors` table below):
--   [A] Kanagawa-vivid (theme-native, brighter than Diagnostic groups) — ACTIVE
--       error #FF5D62  warn #FF9E3B  info #7E9CD8  hint #98BB6C  default #957FB8  test #D27E99
--   [B] Tailwind-vivid (your old palette)
--       error #DC2626  warn #FBBF24  info #2563EB  hint #10B981  default #7C3AED  test #FF00FF
--   [C] Neon / max saturation
--       error #FF3B30  warn #FF9F0A  info #0A84FF  hint #30D158  default #BF5AF2  test #FF2D55

return {
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local icons = require("config.icons")
      -- Source the vivid colors from kanagawa's named palette (single source of
      -- truth) rather than hardcoding hex; fall back to the [A] literals if
      -- kanagawa's module isn't loaded when this evaluates.
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
          keyword = "wide", -- highlight the keyword region (bg), including surrounding chars
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true, -- treesitter: only match inside comments
          max_line_len = 400,
          exclude = {},
        },
        -- Vivid palette [A], sourced from kanagawa's named colors (not hardcoded).
        -- The `or "#..."` is the fallback if the palette lookup fails; swap to
        -- palette [B]/[C] from the header by changing those fallback hex.
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
