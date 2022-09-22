local status_ok, neogen = pcall(require, "neogen")
if not status_ok then
  return
end

neogen.setup {
  -- Enables Neogen capabilities
  enabled = true,

  -- Go to annotation after insertion, and change to insert mode
  input_after_comment = true,

  -- Configuration for default languages
  languages = {
    python = {
      template = {
        annotation_convention = "google_docstrings"
      }
    },
    java = {
      template = {
        annotation_convention = "javadoc"
      }
    }
  },

  -- Use a snippet engine to generate annotations.
  snippet_engine = "luasnip",

  -- -- Enables placeholders when inserting annotation
  enable_placeholders = true,
  --
  -- -- Placeholders used during annotation expansion
  placeholders_text = {
    ["description"] = "[TODO:description]",
    ["tparam"] = "[TODO:tparam]",
    ["parameter"] = "[TODO:parameter]",
    ["return"] = "[TODO:return]",
    ["class"] = "[TODO:class]",
    ["throw"] = "[TODO:throw]",
    ["varargs"] = "[TODO:varargs]",
    ["type"] = "[TODO:type]",
    ["attribute"] = "[TODO:attribute]",
    ["args"] = "[TODO:args]",
    ["kwargs"] = "[TODO:kwargs]",
  },
  --
  -- -- Placeholders highlights to use. If you don't want custom highlight, pass "None"
  -- placeholders_hl = "None",
}

vim.api.nvim_set_keymap('n', '<leader>an',  "<cmd>Neogen<cr>", {})
