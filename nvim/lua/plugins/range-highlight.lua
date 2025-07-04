local status_ok, range_highlight = pcall(require, "range-highlight")
if not status_ok then
  return
end

range_highlight.setup({
  highlight = {
    group = "Visual",
    priority = 10,
    -- if you want to highlight empty line, set it to true
    to_eol = false,
  },
  -- disable range highlight, if the cmd is matched here. Value here does not accept shorthand
  excluded = { cmd = {} },
  debounce = {
    -- how long to debounce, set to 0 to disable
    wait = 100,
  },
})
