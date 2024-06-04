local status_ok, highlight_undo = pcall(require, "highlight-undo")
if not status_ok then
  return
end

highlight_undo.setup({
  duration = 300,
  undo = {
    hlgroup = "HighlightUndo",
    mode = "n",
    lhs = "u",
    map = "undo",
    opts = {},
  },
  redo = {
    hlgroup = "HighlightUndo",
    mode = "n",
    lhs = "<C-r>",
    map = "redo",
    opts = {},
  },
  highlight_for_count = true,
})
