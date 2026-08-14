-- plugins/treesitter-context.lua — nvim-treesitter-context
--
-- Sticky header at the top of the window showing the enclosing
-- function/class/method as you scroll. Restored your settings — dropped the old
-- `patterns` option (removed from treesitter-context; context is query-driven now).

return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    main = "treesitter-context", -- module name differs from repo; tell lazy so opts→setup works
    opts = {
      enable = true,
      max_lines = 0, -- no limit on context height
      trim_scope = "outer",
      mode = "cursor", -- context follows the cursor's scope (not the topline)
      zindex = 20,
    },
  },
}
