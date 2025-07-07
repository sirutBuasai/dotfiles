local status_ok, snacks = pcall(require, "snacks")
if not status_ok then
  return
end

local extra_config = require("plugins.extra-snacks")

snacks.setup({
  bigfile = { enabled = false },
  dashboard = extra_config.dashboard.config,
  explorer = { enabled = false },
  indent = { enabled = true },
  input = extra_config.input.config,
  notifier = extra_config.notifier.config,
  picker = extra_config.picker.config,
  quickfile = { enabled = true },
  scope = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = false },
  words = { enabled = false },
  zen = extra_config.zen.config,
  styles = {
    input = extra_config.input.style,
    notification = extra_config.notifier.style,
  },
})

-- Animation setting
vim.g.snacks_animate = false
