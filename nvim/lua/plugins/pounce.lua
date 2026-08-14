-- plugins/pounce.lua — rlane/pounce.nvim
--
-- Fuzzy jump-to-location motion. Remaps f/F to Pounce (type a few chars of the
-- target, then a label key to jump). Restored from your old config:
--   • accept_keys / accept_best_key=<enter> / multi_window
--   • f/F mapped in NORMAL, VISUAL, and OPERATOR-PENDING modes, so df/cf/yf
--     operate to a pounce target.
-- Loaded on VeryLazy (not lazy-`keys`) so the operator-pending mapping exists
-- before the first df/cf. Pounce* highlight colors come from kanagawa overrides.

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
