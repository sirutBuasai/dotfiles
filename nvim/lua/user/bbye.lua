vim.api.nvim_set_keymap('n', '<C-w>', 'len(filter(range(1, bufnr("$")), "buflisted(v:val)")) > 1 ? ":Bdelete<CR>" : ":q<CR>"', { expr = true, noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bd', ':Bdelete<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bw', ':Bwipeout<CR>', { noremap = true })
