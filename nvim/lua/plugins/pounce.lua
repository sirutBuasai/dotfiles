return {
  {
    "rlane/pounce.nvim",
    event = "VeryLazy",
    config = function()
      require("pounce").setup({
        accept_keys = "FJGHDKSLANUVRBYTMICEOXWPQZ",
        accept_best_key = "<enter>",
        multi_window = true,
      })
      vim.keymap.set({ "n", "x", "o" }, "f", "<cmd>Pounce<CR>", { desc = "Pounce jump" })
      vim.keymap.set({ "n", "x", "o" }, "F", "<cmd>PounceRepeat<CR>", { desc = "Pounce repeat" })
    end,
  },
}
