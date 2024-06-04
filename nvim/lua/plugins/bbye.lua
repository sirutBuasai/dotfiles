local modes = { "n" }

vim.keymap.set(
  modes,
  "<C-w>",
  "len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1 ? ':Bdelete<CR>' : ':q<CR>'",
  { expr = true, noremap = true }
)
vim.keymap.set(
  modes,
  "<C-S-w>",
  "len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1 ? ':Bwipeout<CR>' : ':q<CR>'",
  { expr = true, noremap = true }
)
vim.keymap.set(modes, "<leader>bd", ":Bdelete<CR>", { noremap = true })
vim.keymap.set(modes, "<leader>bw", ":Bwipeout<CR>", { noremap = true })
