-- init.lua — the single entry point Neovim loads on startup.
--
-- We keep this file deliberately tiny: it does nothing but pull in three
-- focused modules in a specific order. Reading top-to-bottom tells you the
-- whole boot story.
--
-- Order matters:
--   1. options  — set vim.opt.* BEFORE anything else so plugins that read
--                 option values at load time (e.g. leader for keymaps) see
--                 the intended values.
--   2. keymaps  — pure editor mappings that don't depend on any plugin.
--   3. lazy     — bootstraps the plugin manager and loads everything in
--                 lua/plugins/. This comes last because plugins may rely on
--                 options/leader already being set.
--
-- NOTE: <leader> must be set before lazy.nvim loads, otherwise any plugin
-- keymap defined with a "<leader>..." lhs binds against the *old* leader.
-- config.options sets it, and it runs first, so we're safe.

require("config.options")
require("config.keymaps")
require("config.lazy")
