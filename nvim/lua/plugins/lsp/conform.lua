local status_ok, conform = pcall(require, "conform")
if not status_ok then
  return
end

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    python = { "isort", "black" },
    java = { "google-java-format" },
    markdown = { "mdformat" },
    json = { "jq" }
  },
  formatters = {
    black = {
      prepend_args = { "-l", "100" },
    },
    prettier = {
      options = {
        ft_parsers = {
          javascript = "babel",
          javascriptreact = "babel",
          typescript = "typescript",
          typescriptreact = "typescript",
          vue = "vue",
          css = "css",
          scss = "scss",
          less = "less",
          html = "html",
          json = "json",
          jsonc = "json",
          yaml = "yaml",
          markdown = "markdown",
          ["markdown.mdx"] = "mdx",
          graphql = "graphql",
          handlebars = "glimmer",
        },
      },
      prepend_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    },
    stylua = {
      prepend_args = { "--indent-width", "2", "--indent-type", "Spaces" },
    },
    mdformat = {
      prepend_args = { "-" },
    },
  },
})
