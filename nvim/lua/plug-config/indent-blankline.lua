local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

vim.cmd [[highlight IndentBlanklineIndent1 guibg=None gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=Gray15 gui=nocombine]]

vim.opt.list = true
-- vim.opt.listchars = "eol:¬"
vim.opt.listchars = "eol: "

indent_blankline.setup {
  char = "",
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  buftype_exclude = {
    "terminal",
    "nofile",
  },
  indent_blankline_filetype_exclude = {
    "help",
    "dashboard",
    "neogitstatus",
    "NvimTree",
    "Trouble",
  },
  indentLine_enabled = 1,
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
  use_treesitter = false,
  show_current_context = true,
  context_patterns = {
    "class",
    "return",
    "function",
    "method",
    "^if",
    "^while",
    "jsx_element",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
    "if_statement",
    "else_clause",
    "jsx_element",
    "jsx_self_closing_element",
    "try_statement",
    "catch_clause",
    "import_statement",
    "operation_type",
  },
}
