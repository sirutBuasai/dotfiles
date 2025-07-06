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
      syntax_limit_b = 1024 * 150, -- 150KB
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
vim.keymap.set(modes, "<leader>gs", fzf_lua.git_status, opts)
vim.keymap.set(modes, "<leader>gS", fzf_lua.git_stash, opts)
vim.keymap.set(modes, "<leader>gl", fzf_lua.git_commits, opts)
vim.keymap.set(modes, "<leader>gf", fzf_lua.git_bcommits, opts)
vim.keymap.set(modes, "<leader>gbl", fzf_lua.git_blame, opts)
