local status_ok, conform = pcall(require, "conform")
if not status_ok then
  return
end

local opts = { noremap = true, silent = true }

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    python = { "isort", "black" },
    java = { "google-java-format" },
    markdown = { "mdformat" },
    json = { "jq", "prettierd", "prettier" },
    go = { "goimports", "gofmt" },
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
  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_format = "fallback",
  -- },
})

local default_formatting = function()
  conform.format({
    async = true,
    lsp_format = "fallback",
  }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
      end
    end
  end)
end

vim.keymap.set("", "<leader>fm", default_formatting, opts)
