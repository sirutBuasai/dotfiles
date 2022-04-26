lua <<EOF
require("toggleterm").setup{
  open_mapping = [[<c-\>]],
  size = 20,
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 3,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
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
}
EOF
