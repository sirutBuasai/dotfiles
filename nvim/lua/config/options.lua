vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opt = vim.opt

-- -- Line numbers -----------------------------------------------------------
opt.number = true          -- show absolute line numbers
opt.relativenumber = false -- absolute (not relative) numbers
opt.numberwidth = 3        -- reserve 3 cols

-- -- Indentation ------------------------------------------------------------
opt.expandtab = true    -- <Tab> inserts spaces
opt.shiftwidth = 2      -- size of an indent step
opt.tabstop = 2         -- how many columns a literal tab renders as
opt.softtabstop = 2     -- how many columns <Tab>/<BS> move in insert mode
opt.smartindent = true  -- language-aware auto-indent on new lines
opt.autoindent = true   -- copy indent from the current line on <CR>

-- -- Search -----------------------------------------------------------------
opt.ignorecase = true -- case-insensitive search by default
opt.smartcase = true  -- case-sensitive when you have case sensitivity
opt.hlsearch = true   -- highlight all matches

-- -- Clipboard --------------------------------------------------------------
opt.clipboard = "unnamedplus"

-- -- Visual comfort ---------------------------------------------------------
opt.cursorline = true   -- highlight the line the cursor is on
opt.scrolloff = 8       -- keep 8 lines of context above/below the cursor
opt.sidescrolloff = 8   -- keep 8 columns of context left/right (nowrap files)
opt.termguicolors = true -- enable 24-bit RGB color
opt.showmode = false    -- lualine already shows the mode
opt.showtabline = 2     -- always show the tab/buffer line
opt.signcolumn = "yes"  -- always show the sign gutter

-- -- Windows / splits -------------------------------------------------------
opt.splitbelow = true -- horizontal splits open below the current window
opt.splitright = true -- vertical splits open to the right
opt.hidden = true     -- allow switching away from a modified buffer

-- -- Mouse ------------------------------------------------------------------
opt.mouse = "a" -- enable mouse

-- -- Files / persistence ----------------------------------------------------
opt.backup = false      -- no ~ backup file before overwriting
opt.writebackup = false -- no backup even during the write
opt.swapfile = false    -- no .swp files (we trust undofile + git instead)
opt.undofile = true     -- persist undo history to disk between sessions

-- -- Responsiveness ---------------------------------------------------------
opt.updatetime = 250 -- faster CursorHold
opt.timeoutlen = 500 -- ms to wait for a mapped sequence to complete

-- -- QoL --------------------------------------------------------------------
opt.shortmess:append("c")                   -- don't show ins-completion-menu messages
opt.iskeyword:append("-")                   -- treat foo-bar as one "word" for w/e/*.
opt.formatoptions:remove({ "c", "r", "o" }) -- stop auto-inserting comment leaders
opt.inccommand = "split"                    -- live-preview :substitute results
opt.confirm = true                          -- :q with unsaved changes prompts to save
opt.grepprg = "rg --vimgrep"                -- use ripgrep for :grep
opt.grepformat = "%f:%l:%c:%m"              -- parse rg's file:line:col:msg output
opt.jumpoptions = "stack"                   -- jumplist behaves as stack

-- -- Wrapping ----------------------------------------------------------------
opt.breakindent = true  -- wrapped lines keep their indentation
opt.linebreak = true    -- wrap at word boundaries, not mid-word
opt.smoothscroll = true -- scroll by screen-line through wrapped lines

-- -- Folding -----------------------------------------------------------------
opt.foldcolumn = "1"    -- thin fold-marker gutter ("0" to hide)
opt.foldlevel = 99      -- ufo needs a high foldlevel
opt.foldlevelstart = 99 -- start unfolded; fold on demand with zM / za / zK (peek)
opt.foldenable = true

-- -- Typos -------------------------------------------------------------------
local alias = function(name, rhs)
  vim.api.nvim_create_user_command(name, rhs, { bang = true })
end
alias("QA", "qa<bang>")
alias("Qa", "qa<bang>")
alias("Q", "q<bang>")
alias("WA", "wa<bang>")
alias("Wa", "wa<bang>")
alias("W", "w<bang>")
alias("WQ", "wq<bang>")
alias("Wq", "wq<bang>")
