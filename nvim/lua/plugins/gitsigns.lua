local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

local modes = { "n" }

local icons = require("user.icons")

gitsigns.setup({
  signs = {
    untracked = {
      hl = "GitSignsAdd",
      text = icons.ui.Separator,
      numhl = "GitSignsAddNr",
      linehl = "GitSignsAddLn",
    },
    add = {
      hl = "GitSignsAdd",
      text = icons.ui.Separator,
      numhl = "GitSignsAddNr",
      linehl = "GitSignsAddLn",
    },
    change = {
      hl = "GitSignsChange",
      text = icons.ui.Separator,
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
    delete = {
      hl = "GitSignsDelete",
      text = icons.ui.FilledArrow,
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    topdelete = {
      hl = "GitSignsDelete",
      text = icons.ui.FilledArrow,
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    changedelete = {
      hl = "GitSignsChange",
      text = icons.ui.Tilde,
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 100,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
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
