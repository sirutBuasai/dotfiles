local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
  return
end

vim.opt.list = true
vim.opt.listchars = ""
-- vim.opt.listchars = "eol:¬"

indent_blankline.setup {
  enabled = true,
  exclude = {
    filetypes = {
      "help",
      "dashboard",
      "neogitstatus",
      "NvimTree",
      "Trouble",
    },
    buftypes = {
      "terminal",
      "nofile",
    },
  },
  scope = {
    enabled = false,
  },
}
