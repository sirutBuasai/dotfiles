local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

hop.setup()

vim.api.nvim_set_keymap('', 'f',  "<cmd>lua require'hop'.hint_char1()<cr>", {})
vim.api.nvim_set_keymap('', 't',  "<cmd>lua require'hop'.hint_char1({ hint_offset = -1 })<cr>", {})
vim.api.nvim_set_keymap('', '//', "<cmd>lua require'hop'.hint_patterns()<cr>", {})
vim.api.nvim_set_keymap('', '-',  "<cmd>lua require'hop'.hint_lines()<cr>", {})
