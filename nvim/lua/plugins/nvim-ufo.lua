local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
  return
end

ufo.setup()

vim.o.foldcolumn = "0"
vim.o.foldlevel = 0
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.keymap.set("n", "<leader>k", require("ufo").peekFoldedLinesUnderCursor)
