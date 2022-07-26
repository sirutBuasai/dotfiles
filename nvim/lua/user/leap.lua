local status_ok, leap = pcall(require, "leap")
if not status_ok then
  return
end

leap.set_default_keymaps()

leap.setup {
  max_aot_targets = nil,
  highlight_unlabeled = false,
  case_sensitive = false,
  special_keys = {
    repeat_search = '<ENTER>',
    next_match    = '<ENTER>',
    prev_match    = '<TAB>',
    next_group    = '<SPACE>',
    prev_group    = '<TAB>',
  },
}
