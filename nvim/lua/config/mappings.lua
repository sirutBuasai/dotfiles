-- Modes and options
local n = { "n" }
local t = { "t" }
local v = { "v" }
local nv = { "n", "v" }
local noremap = { noremap = true }

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Line navigation -----------------------------------------
-- H to move to start of line
vim.keymap.set(nv, "<S-h>", "^", noremap)
-- L to move to end of line
vim.keymap.set(nv, "<S-l>", "$", noremap)

-- Extend custom line navigation ---------------------------
-- dH to delete to start of line
vim.keymap.set(n, "d<S-h>", "d^", noremap)
-- dL to delete to end of line
vim.keymap.set(n, "d<S-l>", "d$", noremap)
-- cH to change to start of line
vim.keymap.set(n, "d<S-h>", "c^", noremap)
-- cL to change to end of line
vim.keymap.set(n, "d<S-l>", "c$", noremap)

-- Spell checking ------------------------------------------
-- Enable spell checking
vim.keymap.set(n, "<leader>ss", ":set spell<CR>", noremap)
-- Disable spell cheking
vim.keymap.set(n, "<leader>ns", ":set nospell<CR>", noremap)

-- Lazy shift fingers --------------------------------------
-- Allows QA to quit all
vim.cmd([[ :command QA qa ]])
-- Allows Qa to quit all
vim.cmd([[ :command Qa qa ]])
-- Allows Q to quit
vim.cmd([[ :command Q q ]])
-- Allows WA to write all
vim.cmd([[ :command WA wa ]])
-- Allows Qa to write all
vim.cmd([[ :command Wa wa ]])
-- Allows W to write
vim.cmd([[ :command W w ]])
-- Allows WQ to write and quit
vim.cmd([[ :command WQ wq ]])
-- Allows Wq to write and quit
vim.cmd([[ :command Wq wq ]])

-- Window splitting ----------------------------------------
-- Split window vertically
vim.keymap.set(n, "<leader>vs", ":vs<CR>", noremap)
-- Split window horizontally
vim.keymap.set(n, "<leader>hs", ":sp<CR>", noremap)

-- Replace words -------------------------------------------
-- Replace current word and move to the next occurence
vim.keymap.set(n, "c*", "/\\<<C-r>=expand('<cword>')<CR>\\>\\C<CR>``cgn", noremap)
vim.keymap.set(n, "d*", "/\\<<C-r>=expand('<cword>')<CR>\\>\\C<CR>``dgn", noremap)
-- Replace current word and move to the previous occurence
vim.keymap.set(n, "c#", "?\\<<C-r>=expand('<cword>')<CR>\\>\\C<CR>``cgN", noremap)
vim.keymap.set(n, "d#", "?\\<<C-r>=expand('<cword>')<CR>\\>\\C<CR>``dgN", noremap)

-- Highlight the whole file --------------------------------
vim.keymap.set(n, "\\", "ggVG")

-- Remove command history ----------------------------------
vim.keymap.set(n, "q:", "<nop>", noremap)

-- Close buffer window -------------------------------------
vim.keymap.set(n, "<C-q>", ":q<CR>", noremap)

-- Delete and paste text without yanking -------------------
-- Delete without yanking
vim.keymap.set(n, "<leader>dd", '"_dd', noremap)
vim.keymap.set(v, "<leader>d", '"_d', noremap)
-- Replace currently selected text without yanking
vim.keymap.set(v, "<leader>p", '"_dP', noremap)

-- Terminal navigation -------------------------------------
-- Ctrl+h to go to left window
vim.keymap.set(t, "<C-h>", "<cmd>wincmd h<CR>", noremap)
-- Ctrl+j to go to bottom window
vim.keymap.set(t, "<C-j>", "<cmd>wincmd j<CR>", noremap)
-- Ctrl+k to go to top window
vim.keymap.set(t, "<C-k>", "<cmd>wincmd k<CR>", noremap)
-- Ctrl+l to go to right window
vim.keymap.set(t, "<C-l>", "<cmd>wincmd l<CR>", noremap)
-- Esc to go to normal mode in terminal
vim.keymap.set(t, "<esc>", "<C-\\><C-n>", noremap)
