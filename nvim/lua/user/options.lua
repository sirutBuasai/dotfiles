local options = {
  autoindent = true, -- Set auto indentation
  backspace = { "indent", "eol", "start" }, -- Allow backspace to work as normal
  backup = false, -- Creates a backup file
  clipboard = "unnamedplus", -- Allows neovim to access the system clipboard
  cmdheight = 0, -- More space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- Mostly just for cmp
  conceallevel = 0, -- So that `` is visible in markdown files
  cursorline = true, -- Highlight the current line
  encoding = "utf-8", -- Display encoding
  expandtab = true, -- Convert tabs to spaces
  fileencoding = "utf-8", -- The encoding written to a file
  hidden = true, -- Required to keep multiple buffers open
  hlsearch = true, -- Highlight all matches on previous search pattern
  ignorecase = true, -- Ignore case in search patterns
  laststatus = 2, -- Always display last status
  modifiable = true, -- Set buffer modifible
  mouse = "a", -- Allow the mouse to be used in neovim
  number = true, -- Set numbered lines
  numberwidth = 3, -- Set number column width to 3 {default 4}
  pumheight = 10, -- Pop up menu height
  relativenumber = false, -- Set relative numbered lines
  ruler = true, -- Show cursor position at all times
  scrolloff = 8, -- Minimal number of screen lines to keep above and below the cursor
  shiftwidth = 2, -- The number of spaces inserted for each indentation
  showmode = false, -- We don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- Always show tabs
  sidescrolloff = 8, -- Minimal number of screen columns either side of cursor if wrap is `false`
  signcolumn = "auto:1-2", -- Always show the sign column, otherwise it would shift the text each time
  smartcase = true, -- Smart case
  smartindent = true, -- Make indenting smarter again
  smarttab = true, -- Auto detect tab sizes
  softtabstop = 2, --Number of spaces inserted instead of a tab character
  splitbelow = true, -- Force all horizontal splits to go below current window
  splitright = true, -- Force all vertical splits to go to the right of current window
  swapfile = false, -- Creates a swapfile
  tabstop = 2, -- Insert 2 spaces for a tab
  termguicolors = true, -- Set term gui colors (most terminals support this)
  timeoutlen = 500, -- Time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- Enable persistent undo
  updatetime = 250, -- Faster completion (4000ms default)
  wrap = false, -- Display long lines instead of one line
  writebackup = false, -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  list = false, -- Remove ^I from indentation
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append("c") -- Don't give |ins-completion-menu| messages
vim.opt.iskeyword:append("-") -- Hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
