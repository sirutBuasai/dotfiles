local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

local modes = { "n" }

local icons = require("config.icons")

gitsigns.setup({
  signs = {
    untracked = {
      text = icons.ui.DottedSeparator,
    },
    add = {
      text = icons.ui.Separator,
    },
    change = {
      text = icons.ui.Separator,
    },
    delete = {
      text = icons.ui.FilledArrow,
    },
    topdelete = {
      text = icons.ui.FilledArrow,
    },
    changedelete = {
      text = icons.ui.Tilde,
    },
  },
  signs_staged = {
    untracked = {
      text = icons.ui.DottedSeparator,
    },
    add = {
      text = icons.ui.Separator,
    },
    change = {
      text = icons.ui.Separator,
    },
    delete = {
      text = icons.ui.FilledArrow,
    },
    topdelete = {
      text = icons.ui.FilledArrow,
    },
    changedelete = {
      text = icons.ui.Tilde,
    },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 100,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },

  vim.keymap.set(modes, "]h", gitsigns.next_hunk, { noremap = true }),
  vim.keymap.set(modes, "[h", gitsigns.prev_hunk, { noremap = true }),
  vim.keymap.set(modes, "<leader>gh", gitsigns.preview_hunk, { noremap = true }),
  vim.keymap.set(modes, "<leader>sh", gitsigns.stage_hunk, { noremap = true }),
  vim.keymap.set(modes, "<leader>sb", gitsigns.stage_buffer, { noremap = true }),
  vim.keymap.set(modes, "<leader>rh", gitsigns.reset_hunk, { noremap = true }),
  vim.keymap.set(modes, "<leader>rb", gitsigns.reset_buffer, { noremap = true }),
  vim.keymap.set(modes, "<leader>ghb", gitsigns.toggle_current_line_blame, { noremap = true }),
})
