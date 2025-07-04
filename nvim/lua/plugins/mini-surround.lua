local status_ok, mini_surround = pcall(require, "mini.surround")
if not status_ok then
  return
end

mini_surround.setup({
  custom_surroundings = nil,
  highlight_duration = 500,
  mappings = {
    add = "ys", -- Add surrounding in Normal and Visual modes
    delete = "ds", -- Delete surrounding
    find = "", -- Find surrounding (to the right)
    find_left = "", -- Find surrounding (to the left)
    highlight = "ch", -- Highlight surrounding
    replace = "cs", -- Replace surrounding
    update_n_lines = "", -- Update `n_lines`
    suffix_last = "", -- Suffix to search with "prev" method
    suffix_next = "", -- Suffix to search with "next" method
  },
  n_lines = 100,
  respect_selection_type = false,
  search_method = "cover_or_nearest",
  silent = true,
})
