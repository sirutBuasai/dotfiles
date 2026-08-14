-- plugins/bufferline.lua — akinsho/bufferline.nvim
--
-- Tab-like buffer strip along the top (showtabline=2 keeps it always shown).
-- Restored from your prior config: flat TabLine-matched look, custom glyphs,
-- thin separators, and the NvimTree offset so the tree doesn't overlap the strip.
-- close/right-mouse rewired to Snacks.bufdelete (Bdelete/vim-bbye no longer used).

return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "echasnovski/mini.icons" }, -- file icons via mini.icons' devicons mock
  config = function()
    local icons = require("config.icons")

    require("bufferline").setup({
      options = {
        numbers = "none",
        -- rewired from "Bdelete! %d" → snacks (we dropped vim-bbye's :Bdelete):
        close_command = function(n)
          Snacks.bufdelete(n)
        end,
        right_mouse_command = function(n)
          Snacks.bufdelete(n)
        end,
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
          icon = icons.ui.Separator,
          style = "icon",
        },
        buffer_close_icon = icons.ui.Close,
        modified_icon = icons.git.Unstaged,
        close_icon = icons.ui.BoldClose,
        left_trunc_marker = icons.ui.TruncLeft,
        right_trunc_marker = icons.ui.TruncRight,
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        tab_size = 20,
        diagnostics = false, -- diagnostics shown in lualine instead
        offsets = { { filetype = "NvimTree", text = "", padding = 0 } },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "thin",
        enforce_regular_tabs = true,
        always_show_bufferline = true,
      },
      highlights = {
        fill = {
          fg = { attribute = "fg", highlight = "TabLine" },
          bg = { attribute = "bg", highlight = "TabLine" },
        },
        background = {
          fg = { attribute = "fg", highlight = "TabLine" },
          bg = { attribute = "bg", highlight = "TabLine" },
        },
        buffer_visible = {
          fg = { attribute = "fg", highlight = "TabLine" },
          bg = { attribute = "bg", highlight = "TabLine" },
        },
        close_button = {
          fg = { attribute = "fg", highlight = "TabLine" },
          bg = { attribute = "bg", highlight = "TabLine" },
        },
        close_button_visible = {
          fg = { attribute = "fg", highlight = "TabLine" },
          bg = { attribute = "bg", highlight = "TabLine" },
        },
        tab_selected = {
          fg = { attribute = "fg", highlight = "Normal" },
          bg = { attribute = "bg", highlight = "Normal" },
        },
        tab = {
          fg = { attribute = "fg", highlight = "TabLine" },
          bg = { attribute = "bg", highlight = "TabLine" },
        },
        tab_close = {
          fg = { attribute = "fg", highlight = "TabLineSel" },
          bg = { attribute = "bg", highlight = "Normal" },
        },
        duplicate_selected = {
          fg = { attribute = "fg", highlight = "TabLineSel" },
          bg = { attribute = "bg", highlight = "TabLineSel" },
          italic = true,
        },
        duplicate_visible = {
          fg = { attribute = "fg", highlight = "TabLine" },
          bg = { attribute = "bg", highlight = "TabLine" },
          italic = true,
        },
        duplicate = {
          fg = { attribute = "fg", highlight = "TabLine" },
          bg = { attribute = "bg", highlight = "TabLine" },
          italic = true,
        },
        modified = {
          fg = { attribute = "fg", highlight = "TabLine" },
          bg = { attribute = "bg", highlight = "TabLine" },
        },
        modified_selected = {
          fg = { attribute = "fg", highlight = "Normal" },
          bg = { attribute = "bg", highlight = "Normal" },
        },
        modified_visible = {
          fg = { attribute = "fg", highlight = "TabLine" },
          bg = { attribute = "bg", highlight = "TabLine" },
        },
        separator = {
          fg = { attribute = "bg", highlight = "TabLine" },
          bg = { attribute = "bg", highlight = "TabLine" },
        },
        separator_selected = {
          fg = { attribute = "bg", highlight = "Normal" },
          bg = { attribute = "bg", highlight = "Normal" },
        },
        indicator_selected = {
          fg = { attribute = "fg", highlight = "DiagnosticHint" }, -- was LspDiagnosticsDefaultHint (removed in nvim 0.6+)
          bg = { attribute = "bg", highlight = "Normal" },
        },
      },
    })
  end,
}
