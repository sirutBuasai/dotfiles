local status_ok, fzf_lua = pcall(require, "fzf-lua")
if not status_ok then
  return
end

local modes = { "n" }

local opts = { noremap = true }

fzf_lua.setup({
  actions = {
    oldfiles = {
      include_current_session = true,
    },
  },
  fzf_opts = {
    ["--cycle"] = true,
  },
  previewers = {
    builtin = {
      syntax_limit_b = 1024 * 100, -- 100KB
    },
  },
})

-- Fzflua keybindings
vim.keymap.set(modes, "<leader>ff", fzf_lua.files, opts)
vim.keymap.set(modes, "<leader>fb", fzf_lua.buffers, opts)
vim.keymap.set(modes, "<leader>fg", fzf_lua.live_grep_glob, opts)
vim.keymap.set(modes, "<leader>fr", fzf_lua.oldfiles, opts)
vim.keymap.set(modes, "<leader>fk", fzf_lua.keymaps, opts)
vim.keymap.set(modes, "<leader>fh", fzf_lua.helptags, opts)
vim.keymap.set(modes, "<leader>f?", fzf_lua.builtin, opts)
