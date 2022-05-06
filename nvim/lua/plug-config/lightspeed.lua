local status_ok, lightspeed = pcall(require, "lightspeed")
if not status_ok then
  return
end

lightspeed.setup {
  ignore_case = false,
  exit_after_idle_msecs = {
    unlabeled = 1000,
    labeled = nil
  },
  jump_to_unique_chars = {
    safety_timeout = 400
  },
  special_keys = {
    next_match_group = '<space>',
    prev_match_group = '<tab>',
  },
}

vim.cmd [[ highlight LightspeedLabel guifg=#87D7FF ]]
vim.cmd [[ highlight LightspeedLabelDistant guifg=#FFAFD7 ]]
vim.cmd [[ highlight LightspeedShortcut guifg=#000000 guibg=#87D7FF ]]
vim.cmd [[ map <expr> ; "<Plug>Lightspeed_;_sx" ]]
vim.cmd [[ map <expr> , "<Plug>Lightspeed_,_sx" ]]
