-- plugins/diffview.lua — sindrets/diffview.nvim
--
-- Dedicated tab for reviewing whole-tree diffs and git history. Restored from
-- your prior config: enhanced diff highlighting, custom folder/fold icons, tree
-- file panel (left, 35w), merge_tool diff3_mixed, and gf → open-in-new-tab.
--
-- NOTE: your old config also spelled out ~40 keymaps — those were diffview's
-- DEFAULTS (disable_defaults stays false, so they're still active). We only
-- re-declare the one real deviation: gf → goto_file_tab.

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  keys = {
    { "<leader>do", "<cmd>DiffviewOpen<CR>", desc = "Diffview: open" },
    { "<leader>dc", "<cmd>DiffviewClose<CR>", desc = "Diffview: close" },
    { "<leader>dh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview: file history (current file)" },
  },
  config = function()
    local icons = require("config.icons")
    local actions = require("diffview.actions")

    require("diffview").setup({
      enhanced_diff_hl = true, -- default false; better diff coloring
      use_icons = true,
      icons = {
        folder_closed = icons.documents.Folder,
        folder_open = icons.documents.OpenFolder,
      },
      signs = {
        fold_closed = icons.ui.ArrowClosed,
        fold_open = icons.ui.ArrowOpen,
        done = icons.ui.Check,
      },
      view = {
        default = { layout = "diff2_horizontal" },
        merge_tool = { layout = "diff3_mixed", disable_diagnostics = true },
        file_history = { layout = "diff2_horizontal" },
      },
      file_panel = {
        listing_style = "tree",
        tree_options = { flatten_dirs = true, folder_statuses = "only_folded" },
        win_config = { position = "left", width = 35 },
      },
      file_history_panel = {
        log_options = {
          git = {
            single_file = { max_count = 512, follow = true },
            multi_file = { max_count = 128 },
          },
        },
        win_config = { position = "bottom", height = 16 },
      },
      keymaps = {
        -- defaults stay on; only override gf to open the file in a new tab
        view = { ["gf"] = actions.goto_file_tab },
        file_panel = { ["gf"] = actions.goto_file_tab },
      },
    })

    vim.opt.fillchars:append({ diff = "/" }) -- '/' filler lines in diff views
  end,
}
