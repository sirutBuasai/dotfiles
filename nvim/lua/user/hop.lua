local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

hop.setup()

-- fF/tT attempts to mimic original fF/tT vim keybinds without specifying directions.
-- However, this swaps the behavior of f/t when going backwards when doing a command like 'df{char}'
vim.api.nvim_set_keymap('', 't',  "<cmd>lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.AFTER_CURSOR, hint_offset = -1})<cr>", {})
vim.api.nvim_set_keymap('', 'T',  "<cmd>lua require'hop'.hint_char1({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, hint_offset = -1})<cr>", {})

-- utility hop commands
vim.api.nvim_set_keymap('', '-',  "<cmd>lua require'hop'.hint_lines()<cr>", {})
