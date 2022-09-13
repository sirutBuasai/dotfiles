local status_ok, pounce = pcall(require, "pounce")
if not status_ok then
  return
end

pounce.setup{
  accept_keys = "FJKDLSAHGNUVRBYTMICEOXWPQZ",
  accept_best_key = "<enter>",
  multi_window = true,
  debug = false,
}

vim.api.nvim_set_keymap('', 'f',  "<cmd>Pounce<cr>", {})
vim.api.nvim_set_keymap('', 'F',  "<cmd>PounceRepeat<cr>", {})
