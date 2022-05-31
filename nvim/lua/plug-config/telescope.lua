local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.setup({
  defaults = {
    layout_strategy = "vertical",
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ["<C-d>"] = "delete_buffer",
        }
      }
    },
  },
})

vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files cwd=..<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fc', ':Telescope find_files<CR>',        { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>',           { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>',         { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>',         { noremap = true })
