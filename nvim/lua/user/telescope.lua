local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

-- Telescope setups
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
  extensions = {
    aerial = {
      show_nesting = true
    }
  }
})

-- Load telescope extensions
telescope.load_extension("aerial")

-- Telescope keybindings
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files cwd=..<CR>',                         { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>',                                   { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>f/', ':Telescope current_buffer_fuzzy_find previewer=false<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>',                                 { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fa', ':Telescope aerial<CR>',                                    { noremap = true })
