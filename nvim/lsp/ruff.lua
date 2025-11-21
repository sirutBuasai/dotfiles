return {
  on_attach = function(client, _)
    client.server_capabilities.hoverProvider = false
  end,
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    "ruff.toml",
    ".ruff.toml",
    ".git",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
  },
}
