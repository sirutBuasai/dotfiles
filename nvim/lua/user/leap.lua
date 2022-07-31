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
    repeat_search = '<enter>',
    next_match    = '<enter>',
    prev_match    = '<tab>',
    next_group    = '<space>',
    prev_group    = '<tab>',
  },
}
