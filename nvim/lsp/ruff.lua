-- lsp/ruff.lua — Python linter/formatter LSP (fast). Disable ruff's hover so
-- pyright is the single hover provider (avoids duplicate hover popups).
-- cmd/filetypes/root_markers come from nvim-lspconfig defaults.
return {
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
  end,
}
