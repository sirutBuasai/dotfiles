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
vim.keymap.set("n", "<C-k>", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    -- choose one of coc.nvim and nvim lsp
    vim.fn.CocActionAsync("definitionHover") -- coc.nvim
    vim.lsp.buf.hover()
  end
end)
