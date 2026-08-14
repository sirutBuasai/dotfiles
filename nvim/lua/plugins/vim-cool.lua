-- plugins/vim-cool.lua — auto-clear search highlight.
--
-- vim-cool turns hlsearch off automatically once you move away from matches
-- and back on when you search again — no manual :noh needed.

return {
  { "romainl/vim-cool", event = "VeryLazy" },
}
