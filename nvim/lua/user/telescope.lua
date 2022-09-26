local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local modes = { 'n' }

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
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
})

-- Load telescope extensions
telescope.load_extension('fzf')
telescope.load_extension("aerial")

-- Telescope keybindings
vim.keymap.set(modes, '<leader>ff', ':Telescope find_files<CR>',                                { noremap = true })
vim.keymap.set(modes, '<leader>fb', ':Telescope buffers<CR>',                                   { noremap = true })
vim.keymap.set(modes, '<leader>f/', ':Telescope current_buffer_fuzzy_find previewer=false<CR>', { noremap = true })
vim.keymap.set(modes, '<leader>fg', ':Telescope live_grep<CR>',                                 { noremap = true })
vim.keymap.set(modes, '<leader>fa', ':Telescope aerial<CR>',                                    { noremap = true })
