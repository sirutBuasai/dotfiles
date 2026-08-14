-- lsp/lua_ls.lua — per-server overrides for the Lua language server.
--
-- Neovim 0.11+ automatically reads this file (matched by the server name
-- "lua_ls") and merges the returned table on top of nvim-lspconfig's default
-- lua_ls config. No setup() call needed — just return a config table.
--
-- These settings tune lua_ls for editing *Neovim config* specifically:
--   * runtime.version = LuaJIT — Neovim embeds LuaJIT, not vanilla Lua 5.x.
--   * diagnostics.globals = {'vim'} — silence "undefined global `vim`"
--     warnings, since `vim` is injected by the editor at runtime.
--   * workspace.library = the Neovim runtime files — gives completion and
--     go-to-definition for the whole `vim.*` API.
--   * checkThirdParty = false — stop lua_ls prompting to configure detected
--     third-party libraries (love2d, etc.); irrelevant for config editing.
--   * telemetry.enable = false — don't phone home.

return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}
