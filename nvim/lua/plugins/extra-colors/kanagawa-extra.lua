local status_ok, kanagawa = pcall(require, "kanagawa")
if not status_ok then
  return
end

kanagawa.setup({
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
      ["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
      ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
      ["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
      ["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
      ["@markup.list.markdown"] = { link = "Function" }, -- + list
      ["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
      ["@markup.list.checked.markdown"] = { link = "WarningMsg" }, -- - [X] checked list item
      PounceMatch = { bold = true, fg = "#adadad", bg = "#555555" },
      PounceGap = { bold = true, fg = "#adadad", bg = "#444444" },
      PounceAccept = { bold = true, fg = "#111111", bg = "#ff69a2" },
      PounceAcceptBest = { bold = true, fg = "#111111", bg = "#fcba03" },
      PounceCursorAccept = { bold = true, fg = "#111111", bg = "#ff69a2" },
      PounceCursorAcceptBest = { bold = true, fg = "#111111", bg = "#fcba03" },
    }
  end,
})
