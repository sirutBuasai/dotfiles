local modes = { "n" }

local opts = { noremap = true }

-- Buffer Management ---------------------------------------
vim.keymap.set(modes, "<leader>bd", function()
  Snacks.bufdelete()
end, { noremap = true })
vim.keymap.set(
  modes,
  "<C-w>",
  "len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1 ? ':lua Snacks.bufdelete()<CR>' : ':q<CR>'",
  { expr = true, noremap = true }
)

-- Git URL -------------------------------------------------
vim.keymap.set(modes, "<leader>gB", function()
  Snacks.gitbrowse()
end, { desc = "[G]it [B]rowse" })

-- Notifier ------------------------------------------------
vim.keymap.set(modes, "<leader>nh", function()
  Snacks.notifier.show_history()
end, { desc = "[N]otification [H]istory" })
vim.keymap.set(modes, "<leader>un", function()
  Snacks.notifier.hide()
end, { desc = "Dismiss All [N]otifications" })

-- Picker --------------------------------------------------
vim.keymap.set(modes, "<leader>ff", function()
  Snacks.picker.files()
end, opts)
vim.keymap.set(modes, "<leader>fb", function()
  Snacks.picker.grep_buffers()
end, opts)
vim.keymap.set(modes, "<leader>fB", function()
  Snacks.picker.buffers()
end, opts)
vim.keymap.set(modes, "<leader>fg", function()
  Snacks.picker.grep()
end, opts)
vim.keymap.set(modes, "<leader>fr", function()
  Snacks.picker.recent({ filter = { cwd = true } })
end, opts)
vim.keymap.set(modes, "<leader>fk", function()
  Snacks.picker.keymaps()
end, opts)
vim.keymap.set(modes, "<leader>fh", function()
  Snacks.picker.help()
end, opts)
vim.keymap.set(modes, "<leader>gs", function()
  Snacks.picker.git_status()
end, opts)
vim.keymap.set(modes, "<leader>gS", function()
  Snacks.picker.git_stash()
end, opts)
vim.keymap.set(modes, "<leader>gd", function()
  Snacks.picker.git_diff()
end, opts)
vim.keymap.set(modes, "<leader>gl", function()
  Snacks.picker.git_log()
end, opts)
vim.keymap.set(modes, "<leader>gf", function()
  Snacks.picker.git_log_file()
end, opts)
vim.keymap.set(modes, "<leader>gL", function()
  Snacks.picker.git_log_line()
end, opts)

-- Zen -----------------------------------------------------
vim.keymap.set(modes, "<leader>z", function()
  Snacks.zen()
end, { desc = "Toggle Zen Mode" })
