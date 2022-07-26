local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup {
  signs = {
    add          = { hl = "GitSignsAdd",    text = "▎",  numhl = "GitSignsAddNr",    linehl = "GitSignsAddLn" },
    change       = { hl = "GitSignsChange", text = "▎",  numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete       = { hl = 'GitSignsDelete', text = "契", numhl='GitSignsDeleteNr',   linehl='GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = "契", numhl='GitSignsDeleteNr',   linehl='GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = "~",  numhl='GitSignsChangeNr',   linehl='GitSignsChangeLn' },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
}
vim.api.nvim_set_keymap('n', '<leader>gh', ':Gitsigns preview_hunk<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gn', ':Gitsigns next_hunk<CR>',    { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gb', ':Gitsigns prev_hunk<CR>',    { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sh', ':Gitsigns stage_hunk<CR>',   { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>sb', ':Gitsigns stage_buffer<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rh', ':Gitsigns reset_hunk<CR>',   { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rb', ':Gitsigns reset_buffer<CR>', { noremap = true })

vim.cmd[[ highlight GitSignsAdd guifg=#87FF87 ]]
vim.cmd[[ highlight GitSignsChange guifg=#8787FF ]]
vim.cmd[[ highlight GitSignsDelete guifg=#FF8787 ]]
