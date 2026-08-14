-- config/keymaps.lua — global, plugin-independent key mappings.
--
-- Plugin-specific maps (pickers, LSP, git hunks, motions) live next to their
-- plugin spec so they load lazily with that plugin. Only editor-core maps
-- that make sense with a bare Neovim belong here.

local map = vim.keymap.set

-- ── Line-wise navigation with Shift ───────────────────────────────────────
-- Reclaim H/L (which by default jump to top/bottom of the *screen*) as
-- "go to first/last non-blank char of the line". Far more useful day-to-day
-- than the screen-position jumps.
map({ "n", "v" }, "<S-h>", "^", { desc = "Go to start of line" })
map({ "n", "v" }, "<S-l>", "$", { desc = "Go to end of line" })

-- ── Operators that reuse the H/L "line ends" idea ─────────────────────────
-- BUG FIX: the previous config bound dH/dL twice (a copy-paste slip) and
-- never bound the change variants cH/cL. All four are bound correctly here:
--   dH = delete to start of line   dL = delete to end of line
--   cH = change to start of line   cL = change to end of line
map("n", "dH", "d^", { desc = "Delete to start of line" })
map("n", "dL", "d$", { desc = "Delete to end of line" })
map("n", "cH", "c^", { desc = "Change to start of line" })
map("n", "cL", "c$", { desc = "Change to end of line" })

-- ── Window splits ─────────────────────────────────────────────────────────
map("n", "<leader>vs", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>hs", ":split<CR>", { desc = "Horizontal split" })

-- ── Change/delete the word under the cursor, repeatably ───────────────────
-- The cgn/dgn idiom: `*` (or `#`) searches for the word under the cursor and
-- leaves it as the current search pattern, then cgn changes the *next* match.
-- Because cgn is dot-repeatable, you can then press `.` to hit each following
-- occurrence, or `n` to skip one. `c*` starts the flow forward; `c#` backward.
-- The leading `*`/`#` also positions us on the first target.
map("n", "c*", "*``cgn", { desc = "Change word under cursor (forward, .-repeat)" })
map("n", "d*", "*``dgn", { desc = "Delete word under cursor (forward, .-repeat)" })
map("n", "c#", "#``cgN", { desc = "Change word under cursor (backward, .-repeat)" })
map("n", "d#", "#``dgN", { desc = "Delete word under cursor (backward, .-repeat)" })

-- ── Misc editor conveniences ──────────────────────────────────────────────
map("n", "\\", "ggVG", { desc = "Select entire file" })
-- q: opens the command-line *window* by accident far more often than on
-- purpose; disable it. (Command-line history is available via <C-f> instead.)
map("n", "q:", "<nop>", { desc = "Disable command-line window" })
map("n", "<C-q>", ":q<CR>", { desc = "Quit window" })

-- ── Register-preserving delete/paste ──────────────────────────────────────
-- The "_ register is the black hole: writes to it are discarded. Using it for
-- delete/paste means these operations don't clobber whatever you last yanked.
map("n", "<leader>dd", '"_dd', { desc = "Delete line (keep yank register)" })
map("v", "<leader>d", '"_d', { desc = "Delete selection (keep yank register)" })
-- Paste over a visual selection without losing the yanked text: delete the
-- selection into the black hole, then paste Before. This is the classic
-- "paste without clobber" trick.
map("v", "<leader>p", '"_dP', { desc = "Paste over selection (keep yank register)" })

-- ── Terminal mode ─────────────────────────────────────────────────────────
-- Make split navigation work from inside a :terminal without first escaping
-- to normal mode. <cmd>...<CR> runs the command directly from terminal mode.
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Terminal: window left" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Terminal: window down" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Terminal: window up" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Terminal: window right" })
-- <Esc> in terminal mode leaves terminal-insert and returns to normal mode,
-- so you can scroll/copy the terminal buffer like any other buffer.
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal: to normal mode" })

-- ── Spell checking toggles ────────────────────────────────────────────────
map("n", "<leader>ss", ":set spell<CR>", { desc = "Spell check on" })
map("n", "<leader>ns", ":set nospell<CR>", { desc = "Spell check off" })

-- ── Visual: move & re-indent the selection ────────────────────────────────
-- Move the selected lines down/up, then reselect (gv) and re-indent (=).
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
-- Indent left/right and STAY in visual mode so you can repeat with < / >.
map("v", "<", "<gv", { desc = "Indent left (keep selection)" })
map("v", ">", ">gv", { desc = "Indent right (keep selection)" })

-- ── Keep the cursor centered / in place ───────────────────────────────────
-- Half-page jumps recenter the view (zz) so you don't lose your place.
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (centered)" })
-- Join lines without the cursor jumping to the join column: mark z, join, return.
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })
