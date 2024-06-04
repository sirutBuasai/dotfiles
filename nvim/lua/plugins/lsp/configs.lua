local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local servers = {
  "bashls",
  "clangd",
  "jdtls",
  "jsonls",
  "lua_ls",
  "pyright",
  "tsserver",
}

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  automatic_installation = true,
})

mason.setup({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("plugins.lsp.handlers").on_attach,
    capabilities = require("plugins.lsp.handlers").capabilities,
  }

  local has_custom_opts, server_custom_opts = pcall(require, "plugins.lsp.lsp-settings." .. server)

  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end

  lspconfig[server].setup(opts)
end
