return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    main = "treesitter-context",
    opts = {
      enable = true,
      max_lines = 0,
      trim_scope = "outer",
      mode = "cursor",
      zindex = 20,
    },
  },
}
