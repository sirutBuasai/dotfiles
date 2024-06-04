local status_ok, conform = pcall(require, "conform")
if not status_ok then
  return
end

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { { "prettierd", "prettier" } },
    python = { "isort", "black" },
    java = { "google-java-format" },
  },
  format_after_save = {
    lsp_fallback = true,
  },
  formatters = {
    black = {
      prepend_args = { "--fast", "-l",  "100" },
    },
    prettierd = {
      prepend_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    },
    stylua = {
      prepend_args = { "--indent-width", "2", "--indent-type", "Spaces" },
    },
  },
})
