-- plugins/hlargs.lua — m-demare/hlargs.nvim
--
-- Highlights function argument names. Your old config mostly restated defaults
-- (excluded self/cls, paint flags, perf tuning) — omitted here. Only the two
-- real customizations are kept:
--   • color = #B2B9D7 (muted lavender-grey; default is orange #ef9062)
--   • hl_priority = 10000 so the arg color wins over LSP semantic-token /
--     treesitter coloring (default 120). Lower it if you'd rather let the LSP
--     color parameters where it can.

return {
  {
    "m-demare/hlargs.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      color = "#B2B9D7",
      hl_priority = 10000,
      extras = {
        -- HlargsUnused expects a highlight SPEC (a bare `true` errors, since the
        -- plugin passes it straight to nvim_set_hl). Link to the standard dimmed
        -- "unused code" group so unused args read as de-emphasized.
        unused_args = { link = "DiagnosticUnnecessary" },
        -- `true` is special-cased to link @HlargsNamedParams → Hlargs (same color).
        named_parameters = true,
      },
    },
  },
}
