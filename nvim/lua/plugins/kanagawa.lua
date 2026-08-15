return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        overrides = function(colors)
          local theme = colors.theme
          return {
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = "#C0A36E" },
            BlinkCmpMenuBorder = { fg = "", bg = "" },
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            CursorLineNr = { fg = colors.palette.sakuraPink, bg = "NONE" },
            ["@markup.link.url.markdown_inline"] = { link = "Special" },
            ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" },
            ["@markup.italic.markdown_inline"] = { link = "Exception" },
            ["@markup.raw.markdown_inline"] = { link = "String" },
            ["@markup.list.markdown"] = { link = "Function" },
            ["@markup.quote.markdown"] = { link = "Error" },
            ["@markup.list.checked.markdown"] = { link = "WarningMsg" },
            PounceMatch = { bold = true, fg = "#adadad", bg = "#555555" },
            PounceGap = { bold = true, fg = "#adadad", bg = "#444444" },
            PounceAccept = { bold = true, fg = "#111111", bg = "#ff69a2" },
            PounceAcceptBest = { bold = true, fg = "#111111", bg = "#fcba03" },
            PounceCursorAccept = { bold = true, fg = "#111111", bg = "#ff69a2" },
            PounceCursorAcceptBest = { bold = true, fg = "#111111", bg = "#fcba03" },
          }
        end,
      })
      vim.cmd.colorscheme("kanagawa-wave")
    end,
  },
}
