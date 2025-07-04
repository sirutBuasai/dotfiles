local status_ok, todo_comments = pcall(require, "todo-comments")
if not status_ok then
  return
end

local icons = require("config.icons")

local opts = { silent = true }

todo_comments.setup({
  signs = true, -- show icons in the signs column
  sign_priority = 8, -- sign priority
  -- keywords recognized as todo comments
  keywords = {
    FIX = {
      icon = icons.ui.Bug .. " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "ERROR" }, -- a set of other keywords that all map to this FIX keywords
      signs = true, -- configure signs for some keywords individually
    },
    TODO = { icon = icons.ui.BoldCheck, color = "info", signs = true },
    HACK = { icon = icons.ui.Fire, color = "warning", signs = true },
    WARN = { icon = icons.diagnostics.FilledWarning, color = "warning", alt = { "WARNING", "XXX" }, signs = true },
    PERF = { icon = icons.ui.ClockFast, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" }, signs = true },
    NOTE = { icon = icons.ui.Comment, color = "hint", alt = { "INFO" }, signs = true },
    TEST = { icon = icons.ui.TestTube, color = "test", alt = { "TESTING", "PASSED", "FAILED" }, signs = true },
  },
  gui_style = {
    fg = "NONE", -- The gui style to use for the fg highlight group.
    bg = "BOLD", -- The gui style to use for the bg highlight group.
  },
  merge_keywords = true, -- when true, custom keywords will be merged with the defaults
  -- highlighting of the line containing the todo comment
  -- * before: highlights before the keyword (typically comment characters)
  -- * keyword: highlights of the keyword
  -- * after: highlights after the keyword (todo text)
  highlight = {
    before = "", -- "fg" or "bg" or empty
    keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
    after = "fg", -- "fg" or "bg" or empty
    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400, -- ignore lines longer than this
    exclude = {}, -- list of file types to exclude highlighting
  },
  -- list of named colors where we try to extract the guifg from the
  -- list of highlight groups or use the hex color if hl not found as a fallback
  colors = {
    error = { "#DC2626" },
    warning = { "#FBBF24" },
    info = { "#2563EB" },
    hint = { "#10B981" },
    default = { "#7C3AED" },
    test = { "#FF00FF" },
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
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
})

vim.keymap.set("n", "]t", function()
  todo_comments.jump_next()
end, opts)

vim.keymap.set("n", "[t", function()
  todo_comments.jump_prev()
end, opts)
