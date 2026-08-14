-- lsp/pyright.lua — Python type-checking / navigation. ruff owns linting +
-- diagnostics, so pyright's diagnostics are suppressed via a no-op
-- publishDiagnostics handler (avoids double-reporting with ruff). cmd/filetypes/
-- root_markers come from nvim-lspconfig defaults.
return {
  handlers = {
    ["textDocument/publishDiagnostics"] = function() end,
  },
  settings = {
    pyright = {
      disableOrganizeImports = true, -- ruff handles import organization
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        typeCheckingMode = "basic",
        useLibraryCodeForTypes = true,
      },
    },
  },
}
