local status_ok, snacks = pcall(require, "snacks")
if not status_ok then
  return
end

local modes = "n"

local dashboard_config = require("plugins.snacks-dashboard")
local input_config = require("plugins.snacks-input")
local notifier_config = require("plugins.snacks-notifier")
local zen_config = require("plugins.snacks-zen")

snacks.setup({
  bigfile = { enabled = true },
  dashboard = dashboard_config.config,
  explorer = { enabled = false },
  indent = { enabled = true },
  input = input_config,
  notifier = notifier_config.config,
  picker = { enabled = false },
  quickfile = { enabled = true },
  scope = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = false },
  words = { enabled = false },
  zen = zen_config.config,
  styles = {
    input = input_config.style,
    notification = notifier_config.style,
  },
})

-- Animation
vim.g.snacks_animate = false

-- Buffer Management
vim.keymap.set(modes, "<leader>bd", function()
  Snacks.bufdelete()
end, { noremap = true })
vim.keymap.set(
  modes,
  "<C-w>",
  "len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1 ? ':lua Snacks.bufdelete()<CR>' : ':q<CR>'",
  { expr = true, noremap = true }
)

-- Git
vim.keymap.set(modes, "<leader>gB", function()
  Snacks.gitbrowse()
end, { desc = "[G]it [B]rowse" })

-- Notification
vim.keymap.set(modes, "<leader>nh", function()
  Snacks.notifier.show_history()
end, { desc = "[N]otification [H]istory" })
vim.keymap.set(modes, "<leader>un", function()
  Snacks.notifier.hide()
end, { desc = "Dismiss All [N]otifications" })

-- Zen
vim.keymap.set(modes, "<leader>z", function()
  Snacks.zen()
end, { desc = "Toggle Zen Mode" })
