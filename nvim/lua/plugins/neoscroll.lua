local setup_ok, neoscroll = pcall(require, "neoscroll")
if not setup_ok then
  return
end

local config_ok, neoscroll_config = pcall(require, "neoscroll.config")
if not config_ok then
  return
end

neoscroll.setup({
  -- All these keys will be mapped to their corresponding default scrolling animation
  mappings = { "<C-d>", "<C-u>", "<C-y>", "<C-e>", "zz", "zt", "zb" },
  hide_cursor = true, -- Hide cursor while scrolling
  stop_eof = true, -- Stop at <EOF> when scrolling downwards
  respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  easing_function = nil, -- Default easing function
  pre_hook = nil, -- Function to run before the scrolling animation starts
  post_hook = nil, -- Function to run after the scrolling animation ends
  performance_mode = false, -- Disable "Performance Mode" on all buffers.
})

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
-- scroll(lines, move_cursor, time[, easing])
-- z*(half_win_time[, easing])
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "200" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "200" } }
t["<C-y>"] = { "scroll", { "-0.10", "false", "75" } }
t["<C-e>"] = { "scroll", { "0.10", "false", "75" } }
t["zt"] = { "zt", { "10" } }
t["zz"] = { "zz", { "50" } }
t["zb"] = { "zb", { "10" } }

neoscroll_config.set_mappings(t)
