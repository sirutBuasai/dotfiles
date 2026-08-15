return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    config = function()
      local ss = require("smart-splits")
      ss.setup({
        ignored_buftypes = { "nofile", "quickfix", "prompt" },
        ignored_filetypes = { "NvimTree" },
        default_amount = 3,
        at_edge = "stop",
        float_win_behavior = "previous",
        move_cursor_same_row = false,
        cursor_follows_swapped_bufs = false,
        disable_multiplexer_nav_when_zoomed = true,
        ignored_events = { "BufEnter", "WinEnter" },
      })

      -- focus pane
      vim.keymap.set("n", "<C-h>", ss.move_cursor_left, { desc = "Move to left split" })
      vim.keymap.set("n", "<C-j>", ss.move_cursor_down, { desc = "Move to below split" })
      vim.keymap.set("n", "<C-k>", ss.move_cursor_up, { desc = "Move to above split" })
      vim.keymap.set("n", "<C-l>", ss.move_cursor_right, { desc = "Move to right split" })
      vim.keymap.set("n", "<C-\\>", ss.move_cursor_previous, { desc = "Move to previous split" })

      -- resize
      vim.keymap.set("n", "<M-h>", ss.resize_left, { desc = "Resize split left" })
      vim.keymap.set("n", "<M-j>", ss.resize_down, { desc = "Resize split down" })
      vim.keymap.set("n", "<M-k>", ss.resize_up, { desc = "Resize split up" })
      vim.keymap.set("n", "<M-l>", ss.resize_right, { desc = "Resize split right" })

      -- swap pane
      vim.keymap.set("n", "<leader><leader>h", ss.swap_buf_left, { desc = "Swap buffer left" })
      vim.keymap.set("n", "<leader><leader>j", ss.swap_buf_down, { desc = "Swap buffer down" })
      vim.keymap.set("n", "<leader><leader>k", ss.swap_buf_up, { desc = "Swap buffer up" })
      vim.keymap.set("n", "<leader><leader>l", ss.swap_buf_right, { desc = "Swap buffer right" })
    end,
  },
}
