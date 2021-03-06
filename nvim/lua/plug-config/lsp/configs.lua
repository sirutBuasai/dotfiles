local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local lspconfig = require("lspconfig")

local servers = { "jsonls", "sumneko_lua", "pyright", "jdtls", "clangd", "bashls" }

lsp_installer.setup {
  ensure_installed = servers,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    },
  },
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("plug-config.lsp.handlers").on_attach,
    capabilities = require("plug-config.lsp.handlers").capabilities,
    root_dir = vim.loop.cwd,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "plug-config.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  lspconfig[server].setup(opts)
end
