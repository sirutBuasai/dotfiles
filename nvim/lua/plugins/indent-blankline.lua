local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

vim.opt.list = true
vim.opt.listchars = ""
-- vim.opt.listchars = "eol:¬"

indent_blankline.setup {
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
    "^func",
    "^if",
    "^object",
    "^table",
    "argument_list",
    "arguments",
    "block",
    "catch_clause",
    "class",
    "dictionary",
    "do_block",
    "element",
    "else_clause",
    "except",
    "for",
    "if_statement",
    "import_statement",
    "jsx_element",
    "jsx_element",
    "jsx_self_closing_element",
    "method",
    "operation_type",
    "return",
    "try",
    "try_statement",
    "tuple",
    "while",
    "with"
  }
}
