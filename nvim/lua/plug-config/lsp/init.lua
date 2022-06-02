local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("plug-config.lsp.configs")
require("plug-config.lsp.handlers").setup()
require("plug-config.lsp.null-ls")
require("plug-config.lsp.dressing")
