local status_ok, render_markdown = pcall(require, "render-markdown")
if not status_ok then
  return
end

render_markdown.setup({
  completions = {
    lsp = { enabled = true },
    blink = { enabled = true },
  },
})

vim.cmd(":RenderMarkdown disable")

vim.keymap.set("n", "<leader>md", ":RenderMarkdown enable<CR>")
vim.keymap.set("n", "<leader>mdd", ":RenderMarkdown disable<CR>")
