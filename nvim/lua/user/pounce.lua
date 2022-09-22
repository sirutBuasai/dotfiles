local status_ok, pounce = pcall(require, "pounce")
if not status_ok then
  return
end

pounce.setup{
  accept_keys = "FJGHDKSLANUVRBYTMICEOXWPQZ",
  accept_best_key = "<enter>",
  multi_window = true,
  debug = false,
}

local modes = { 'n', 'x', 'o' }

vim.keymap.set(modes, 'f',  "<cmd>Pounce<cr>", {})
vim.keymap.set(modes, 'F',  "<cmd>PounceRepeat<cr>", {})
