return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
  opts = {
    enabled = false,
    latex = { enabled = false },
    completions = {
      lsp = { enabled = true },
    },
    code = {
      border = "thin",
    },
  },
  keys = {
    { "<leader>md", "<cmd>RenderMarkdown enable<CR>", desc = "Markdown render on" },
    { "<leader>mdd", "<cmd>RenderMarkdown disable<CR>", desc = "Markdown render off" },
  },
}
