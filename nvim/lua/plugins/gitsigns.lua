-- plugins/gitsigns.lua — lewis6991/gitsigns.nvim
--
-- Inline, per-hunk git workflow in the sign column: stage, reset, preview,
-- navigate, blame — without leaving the buffer. Keymaps use the modern
-- buffer-local on_attach + nav_hunk API (your old config nested the maps inside
-- setup{} and used the deprecated next_hunk/prev_hunk — fixed here). Custom
-- signs / blame formatter / preview popup are restored from your prior config.

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local icons = require("config.icons")

    require("gitsigns").setup({
      signs = {
        untracked = { text = icons.ui.DottedSeparator },
        add = { text = icons.ui.Separator },
        change = { text = icons.ui.Separator },
        delete = { text = icons.ui.FilledArrow },
        topdelete = { text = icons.ui.FilledArrow },
        changedelete = { text = icons.ui.Tilde },
      },
      signs_staged = {
        untracked = { text = icons.ui.DottedSeparator },
        add = { text = icons.ui.Separator },
        change = { text = icons.ui.Separator },
        delete = { text = icons.ui.FilledArrow },
        topdelete = { text = icons.ui.FilledArrow },
        changedelete = { text = icons.ui.Tilde },
      },
      attach_to_untracked = true, -- default false; show signs for untracked files
      current_line_blame = false, -- toggled via <leader>gb
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 100, -- default 1000; snappier
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      preview_config = {
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function bmap(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "Git: " .. desc })
        end

        -- hunk navigation (modern nav_hunk)
        bmap("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
        bmap("n", "[h", function() gs.nav_hunk("prev") end, "Previous hunk")

        -- inspect
        bmap("n", "<leader>gh", gs.preview_hunk, "Preview hunk")

        -- stage / reset — normal mode = whole hunk, visual mode = selected lines
        bmap("n", "<leader>sh", gs.stage_hunk, "Stage hunk")
        bmap("v", "<leader>sh", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage selected lines")
        bmap("n", "<leader>rh", gs.reset_hunk, "Reset hunk")
        bmap("v", "<leader>rh", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset selected lines")
        bmap("n", "<leader>sb", gs.stage_buffer, "Stage buffer")
        bmap("n", "<leader>rb", gs.reset_buffer, "Reset buffer")

        -- blame: <leader>gb toggles eol virt-text blame; <leader>gB = full popup for the line
        bmap("n", "<leader>gb", gs.toggle_current_line_blame, "Toggle line blame")
        bmap("n", "<leader>gB", function()
          gs.blame_line({ full = true })
        end, "Blame line (full popup)")

        -- inline hunk preview (expands in-buffer, vs the <leader>gh floating popup)
        bmap("n", "<leader>ghh", gs.preview_hunk_inline, "Preview hunk (inline)")

        -- hunk text object: dih / vih / cih operate on the current hunk
        bmap({ "o", "x" }, "ih", gs.select_hunk, "Select hunk (text object)")
      end,
    })
  end,
}
