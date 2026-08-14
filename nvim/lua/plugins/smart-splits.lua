-- plugins/smart-splits.lua — window navigation + resizing across splits/tmux.
--
-- Seamless movement/resizing across BOTH Neovim splits and tmux panes. Its tmux
-- integration relies on a @pane-is-vim var set at runtime, so it MUST load at
-- startup (lazy=false) — a lazily-loaded plugin misses the first cross-boundary
-- <C-hjkl>. Restored from your prior config (minus resize_mode, which upstream
-- removed — use submode.nvim if you ever want a sticky resize sub-mode).

return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    config = function()
      local ss = require("smart-splits")
      ss.setup({
        ignored_buftypes = { "nofile", "quickfix", "prompt" }, -- skip these while resizing
        ignored_filetypes = { "NvimTree" }, -- don't resize when focused on the tree
        default_amount = 3, -- lines/cols per resize step
        at_edge = "stop", -- stop at the last split instead of wrapping
        float_win_behavior = "previous",
        move_cursor_same_row = false,
        cursor_follows_swapped_bufs = false,
        disable_multiplexer_nav_when_zoomed = true, -- don't cross into a zoomed tmux pane
        ignored_events = { "BufEnter", "WinEnter" },
      })

      -- move focus (falls through to the adjacent tmux pane at the nvim edge)
      vim.keymap.set("n", "<C-h>", ss.move_cursor_left, { desc = "Move to left split" })
      vim.keymap.set("n", "<C-j>", ss.move_cursor_down, { desc = "Move to below split" })
      vim.keymap.set("n", "<C-k>", ss.move_cursor_up, { desc = "Move to above split" })
      vim.keymap.set("n", "<C-l>", ss.move_cursor_right, { desc = "Move to right split" })
      vim.keymap.set("n", "<C-\\>", ss.move_cursor_previous, { desc = "Move to previous split" })

      -- resize (seamless: resizes the tmux pane if the boundary is with tmux)
      vim.keymap.set("n", "<M-h>", ss.resize_left, { desc = "Resize split left" })
      vim.keymap.set("n", "<M-j>", ss.resize_down, { desc = "Resize split down" })
      vim.keymap.set("n", "<M-k>", ss.resize_up, { desc = "Resize split up" })
      vim.keymap.set("n", "<M-l>", ss.resize_right, { desc = "Resize split right" })

      -- swap the current buffer with the one in that direction
      vim.keymap.set("n", "<leader><leader>h", ss.swap_buf_left, { desc = "Swap buffer left" })
      vim.keymap.set("n", "<leader><leader>j", ss.swap_buf_down, { desc = "Swap buffer down" })
      vim.keymap.set("n", "<leader><leader>k", ss.swap_buf_up, { desc = "Swap buffer up" })
      vim.keymap.set("n", "<leader><leader>l", ss.swap_buf_right, { desc = "Swap buffer right" })
    end,
  },
}
