-- config/lazy.lua — bootstrap and configure the lazy.nvim plugin manager.
--
-- lazy.nvim is not itself installable via a plugin manager (chicken/egg), so
-- we clone it by hand into the data dir the first time, prepend it to the
-- runtimepath, then hand off to it.

-- Standard location for plugin data: ~/.local/share/nvim/lazy/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Clone lazy.nvim only if it isn't already present. We use `uv.fs_stat`
-- (fast, no shell) to check existence.
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone",
    "--filter=blob:none", -- partial clone: skip file blobs we don't need yet
    "--branch=stable",    -- track the stable release branch, not bleeding main
    repo,
    lazypath,
  })
  -- If git failed, surface the error prominently and bail — continuing would
  -- just produce a confusing cascade of "module 'lazy' not found" errors.
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- Prepend (not append) so lazy.nvim wins any name collisions and is available
-- immediately below.
vim.opt.rtp:prepend(lazypath)

-- Hand control to lazy.nvim.
--   { import = "plugins" }  → recursively load every lua/plugins/*.lua file;
--                             each returns a spec (or list of specs).
--   checker.enabled         → periodically check for plugin updates...
--   checker.notify = false  → ...but don't nag with a popup about it.
--   change_detection.notify → don't pop a toast every time we edit a config
--                             file in this repo; reloading is fine, silently.
require("lazy").setup({
  { import = "plugins" },
}, {
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
})
