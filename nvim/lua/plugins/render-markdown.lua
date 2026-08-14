-- plugins/render-markdown.lua — MeanderingProgrammer/render-markdown.nvim
--
-- Prettier in-buffer markdown rendering. Restored + tuned:
--   • starts DISABLED — edit raw, toggle rendering on with <leader>md to preview
--   • checkbox/callout completions via the in-process LSP source (auto-works with blink)
--   • latex disabled (no pylatexenc dependency)
--   • thin border around fenced code blocks
--   • heading icons: render-markdown defaults (no custom icons)

return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" }, -- only load for markdown files
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- markdown parser
    "echasnovski/mini.icons", -- code-block language icons
  },
  opts = {
    enabled = false, -- start off; :RenderMarkdown enable/toggle still work
    latex = { enabled = false }, -- disabled by default (avoids pylatexenc dep)
    completions = {
      lsp = { enabled = true }, -- recommended path; auto-integrates with blink.cmp
    },
    code = {
      border = "thin", -- subtle thin border framing fenced code blocks
    },
  },
  keys = {
    { "<leader>md", "<cmd>RenderMarkdown enable<CR>", desc = "Markdown render on" },
    { "<leader>mdd", "<cmd>RenderMarkdown disable<CR>", desc = "Markdown render off" },
  },
}
