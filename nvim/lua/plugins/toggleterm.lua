local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

local modes = { "n" }

toggleterm.setup({
  -- open_mapping = [[<leader>\]],
  open_mapping = [[<C-\>]],
  size = function(term)
    if term.direction == "vertical" then
      return vim.o.columns * 0.4
    else
      return 20
    end
  end,
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
  shade_terminals = true,
  shading_factor = 3,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
  direction = "float",
  -- direction = "horizontal",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

vim.keymap.set(modes, "<leader>sl", "<cmd>ToggleTermSendCurrentLine<CR>")
vim.keymap.set("", "<leader>\\f", "<cmd>ToggleTerm direction=float<CR>")
vim.keymap.set("", "<leader>\\h", "<cmd>ToggleTerm direction=horizontal<CR>")
vim.keymap.set("", "<leader>\\v", "<cmd>ToggleTerm direction=vertical<CR>")
