return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      go = { "goimports", "gofmt" },
      lua = { "stylua" },
      sh = { "shfmt" },
      markdown = { "mdformat", "injected" },
      java = { "google-java-format" },
    },
    formatters = {
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
    -- no format_on_save / format_after_save
  },
  keys = {
    {
      "<leader>fm",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" }, function(err)
          if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
          end
        end)
      end,
      mode = { "n", "v" },
      desc = "Format buffer / selection",
    },
  },
}
