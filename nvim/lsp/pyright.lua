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
