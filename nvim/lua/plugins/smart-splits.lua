local status_ok, smart_splits = pcall(require, "smart-splits")
if not status_ok then
  return
end

smart_splits.setup({
  -- Ignored buffer types (only while resizing)
  ignored_buftypes = {
    "nofile",
    "quickfix",
    "prompt",
  },
  -- Ignored filetypes (only while resizing)
  ignored_filetypes = { "NvimTree" },
  default_amount = 3,
  at_edge = "stop",
  float_win_behavior = "previous",
  move_cursor_same_row = false,
  cursor_follows_swapped_bufs = false,
  resize_mode = {
    quit_key = "<ESC>",
    resize_keys = { "h", "j", "k", "l" },
    silent = false,
  },
  ignored_events = {
    "BufEnter",
    "WinEnter",
  },
  disable_multiplexer_nav_when_zoomed = true,
  log_level = "info",
})

-- Resizing splits
vim.keymap.set("n", "<C-9>", smart_splits.resize_left)
vim.keymap.set("n", "<C-0>", smart_splits.resize_down)
vim.keymap.set("n", "<C-->", smart_splits.resize_up)
vim.keymap.set("n", "<C-=>", smart_splits.resize_right)
-- Moving between splits
vim.keymap.set("n", "<C-h>", smart_splits.move_cursor_left)
vim.keymap.set("n", "<C-j>", smart_splits.move_cursor_down)
vim.keymap.set("n", "<C-k>", smart_splits.move_cursor_up)
vim.keymap.set("n", "<C-l>", smart_splits.move_cursor_right)
vim.keymap.set("n", "<C-\\>", smart_splits.move_cursor_previous)
-- Swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", smart_splits.swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", smart_splits.swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", smart_splits.swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", smart_splits.swap_buf_right)
