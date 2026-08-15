local map = vim.keymap.set

-- -- Navigation -------------------------------------------------------------
map({ "n", "v" }, "<S-h>", "^", { desc = "Go to start of line" })
map({ "n", "v" }, "<S-l>", "$", { desc = "Go to end of line" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (centered)" })

-- -- Conveniences -----------------------------------------------------------
map("n", "\\", "ggVG", { desc = "Select entire file" })
map("n", "q:", "<nop>", { desc = "Disable command-line window" })
map("n", "<C-q>", ":q<CR>", { desc = "Quit window" })
map("n", "<leader>ss", ":set spell<CR>", { desc = "Spell check on" })
map("n", "<leader>ns", ":set nospell<CR>", { desc = "Spell check off" })
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- -- Window splits ----------------------------------------------------------
map("n", "<leader>vs", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>hs", ":split<CR>", { desc = "Horizontal split" })

-- -- Change/delete ----------------------------------------------------------
map("n", "c*", "*``cgn", { desc = "Change word under cursor (forward, .-repeat)" })
map("n", "d*", "*``dgn", { desc = "Delete word under cursor (forward, .-repeat)" })
map("n", "c#", "#``cgN", { desc = "Change word under cursor (backward, .-repeat)" })
map("n", "d#", "#``dgN", { desc = "Delete word under cursor (backward, .-repeat)" })
map("n", "dH", "d^", { desc = "Delete to start of line" })
map("n", "cH", "c^", { desc = "Change to start of line" })
map("n", "dL", "d$", { desc = "Delete to end of line" })
map("n", "cL", "c$", { desc = "Change to end of line" })
map("n", "<leader>dd", '"_dd', { desc = "Delete line (keep yank register)" })
map("v", "<leader>d", '"_d', { desc = "Delete selection (keep yank register)" })
map("v", "<leader>p", '"_dP', { desc = "Paste over selection (keep yank register)" })

-- -- Terminal mode ----------------------------------------------------------
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Terminal: window left" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Terminal: window down" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Terminal: window up" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Terminal: window right" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal: to normal mode" })

-- -- Visual mode ------------------------------------------------------------
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<", "<gv", { desc = "Indent left (keep selection)" })
map("v", ">", ">gv", { desc = "Indent right (keep selection)" })
