-- config/options.lua — global editor behavior (vim.opt.*) and a few
-- typo-tolerant command aliases. No plugin code here; this is pure Neovim.

-- Leader keys. These MUST be set before plugins load (see init.lua ordering)
-- because keymap lhs strings capture the leader at definition time, not at
-- press time. Space is a comfortable, chord-free leader; comma is localleader
-- (used for buffer/filetype-local maps).
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opt = vim.opt

-- ── Line numbers ──────────────────────────────────────────────────────────
opt.number = true          -- show absolute line numbers
opt.relativenumber = false -- absolute (not relative) numbers — easier to read
                           -- at a glance; jump-by-count is not our workflow.
opt.numberwidth = 3        -- reserve 3 cols so the gutter doesn't jump around
                           -- until we hit 4-digit line numbers.

-- ── Indentation ───────────────────────────────────────────────────────────
-- 2-space soft tabs everywhere. Language-specific overrides (e.g. Go wanting
-- real tabs) are left to filetype plugins / formatters, not hard-coded here.
opt.expandtab = true    -- <Tab> inserts spaces, not a literal tab char
opt.shiftwidth = 2      -- size of an indent step (>>, <<, autoindent)
opt.tabstop = 2         -- how many columns a literal tab renders as
opt.softtabstop = 2     -- how many columns <Tab>/<BS> move in insert mode
opt.smartindent = true  -- language-aware auto-indent on new lines
opt.autoindent = true   -- copy indent from the current line on <CR>

-- ── Search ────────────────────────────────────────────────────────────────
opt.ignorecase = true -- case-insensitive search by default...
opt.smartcase = true  -- ...but case-sensitive the moment you type a capital.
opt.hlsearch = true   -- highlight all matches (vim-cool clears them for us
                      -- automatically once you move the cursor away).

-- ── Clipboard ─────────────────────────────────────────────────────────────
-- Share Neovim's unnamed register with the OS clipboard so y/p Just Work
-- with other apps. "unnamedplus" targets the "+ (system) register.
opt.clipboard = "unnamedplus"

-- ── Visual comfort ────────────────────────────────────────────────────────
opt.cursorline = true   -- highlight the line the cursor is on
opt.scrolloff = 8       -- keep 8 lines of context above/below the cursor
opt.sidescrolloff = 8   -- keep 8 columns of context left/right (nowrap files)
opt.termguicolors = true -- enable 24-bit RGB color; required by kanagawa and
                         -- basically every modern colorscheme/plugin.
opt.showmode = false    -- lualine already shows the mode; hide the builtin
                        -- "-- INSERT --" line to avoid duplication.
opt.showtabline = 2     -- always show the tab/buffer line (bufferline lives
                        -- here); avoids layout shift when a 2nd buffer opens.
opt.signcolumn = "yes"  -- always show the sign gutter so text doesn't shift as
                        -- git/diagnostic signs appear (old: "auto:1"; use "auto"
                        -- to hide it when empty).

-- ── Windows / splits ──────────────────────────────────────────────────────
opt.splitbelow = true -- horizontal splits open below the current window
opt.splitright = true -- vertical splits open to the right — matches reading
                      -- order and most tiling-WM muscle memory.
opt.hidden = true     -- allow switching away from a modified buffer without
                      -- forcing a write (needed for smooth buffer cycling).

-- ── Mouse ─────────────────────────────────────────────────────────────────
opt.mouse = "a" -- enable mouse in all modes (resize splits, click to move).

-- ── Files / persistence ───────────────────────────────────────────────────
-- We don't want scattered backup/swap files; instead we keep a single
-- persistent undo history so undo survives closing and reopening a file.
opt.backup = false      -- no ~ backup file before overwriting
opt.writebackup = false -- no backup even during the write
opt.swapfile = false    -- no .swp files (we trust undofile + git instead)
opt.undofile = true     -- persist undo history to disk between sessions

-- ── Responsiveness ────────────────────────────────────────────────────────
opt.updatetime = 250 -- faster CursorHold (drives snacks.words, gitsigns, etc.)
opt.timeoutlen = 500 -- ms to wait for a mapped sequence to complete; short
                     -- enough to feel snappy, long enough to chord leader maps.

-- ── Small quality-of-life tweaks ──────────────────────────────────────────
opt.shortmess:append("c")           -- don't show ins-completion-menu messages
                                    -- ("match 1 of 3", etc.) — blink handles UI.
opt.iskeyword:append("-")           -- treat foo-bar as one "word" for w/e/*.
opt.formatoptions:remove({ "c", "r", "o" })
-- Stop auto-inserting comment leaders:
--   c = auto-wrap comments using textwidth
--   r = insert comment leader after <CR> in insert mode
--   o = insert comment leader after o/O
-- Removing these keeps comments from "sticking" when editing around them.

-- ── Wrapping (wrap is on by default) ──────────────────────────────────────
opt.breakindent = true  -- wrapped lines keep their indentation (align under start)
opt.linebreak = true    -- wrap at word boundaries, not mid-word
opt.smoothscroll = true -- scroll by screen-line through wrapped lines (0.10+)

-- ── Editing / search QoL ──────────────────────────────────────────────────
opt.inccommand = "split"       -- live-preview :substitute results (in a split)
opt.confirm = true             -- :q with unsaved changes prompts to save (vs error)
opt.grepprg = "rg --vimgrep"   -- use ripgrep for :grep
opt.grepformat = "%f:%l:%c:%m" -- parse rg's file:line:col:msg output
opt.jumpoptions = "stack"      -- jumplist behaves like browser back/forward
                               -- (a new jump after <C-o> drops the forward entries)

-- ── Typo-tolerant command aliases ─────────────────────────────────────────
-- Everyone fat-fingers the Shift key on :wq / :qa. These user-commands map
-- the common miscapitalizations to the intended lowercase ex-command so a
-- stray Shift doesn't error out. `bang = true` forwards a trailing ! (e.g.
-- :Q! -> q!). We can't override built-in lowercase commands, only define
-- new capitalized ones, which is exactly what we want here.
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
