local status_ok, glow = pcall(require, "glow")
if not status_ok then
  return
end

local modes = { "n" }

glow.setup {
  install_path = "~/.local/bin",  -- default path for installing glow binary
  border = "none",                -- floating window border config
  style = "dark",                 -- filled automatically with your current editor background, you can override using glow json style
  pager = false,
  width = 160,
  height = 90,
  width_ratio = 0.7,              -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
  height_ratio = 0.7,
}

vim.keymap.set(modes, "<leader>md", "<cmd>Glow<cr>", { silent = true, noremap = true })
