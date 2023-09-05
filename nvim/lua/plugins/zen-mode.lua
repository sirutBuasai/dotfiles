local status_ok, zen_mode = pcall(require, "zen-mode")
if not status_ok then
  return
end

local modes = { "n" }

zen_mode.setup {
  window = {
    backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    width = 120, -- width of the Zen window
    height = 1, -- height of the Zen window
    options = {
      signcolumn = "no", -- disable signcolumn
      number = false, -- disable number column
      cursorline = false, -- disable cursorline
      -- relativenumber = false, -- disable relative numbers
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    kitty = {
      enabled = false,
      font = "+4", -- font size increment
    },
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function()
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
  end,
}

vim.keymap.set(modes, "<leader>z", "<cmd>ZenMode<cr>", { silent = true, noremap = true })
