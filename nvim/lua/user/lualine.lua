local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local icons = require("user.icons")

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local colors = {
  darkgray  = '#202328',
  lightgray = '#BBC2CF',
  green     = '#A6E22E',
  lavender  = '#7070F0',
  orange    = '#FD971F',
}

local icon = {
  function()
    return '▊'
  end,
  padding = { left = 0, right = 1 },
}

local filetype = {
  'filetype',
  fmt = string.upper,
  icons_enabled = true,
  icon = nil,
  color = { fg = colors.green, gui = 'bold' }
}

local filename = {
  'filename',
  color = { fg = colors.lightgray, gui = 'bold' }
}

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn' },
  symbols = { error = icons.diagnostics.Error, warn = icons.diagnostics.Warning},
  colored = true,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  'diff',
  colored = true,
  symbols = { added = icons.git.Add, modified = icons.git.Mod, removed = icons.diagnostics.Remove},
  cond = hide_in_width
}

local branch = {
  'branch',
  icons_enabled = true,
  icon = '',
  color = { fg = colors.lightgray }
}

local lsp = {
 function()
    local msg = 'no active lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = '',
  color = { fg = '#ffffff', gui = 'bold' }
}

local location = {
  'location',
  padding = { left = 0, right = 1 },
  color = { fg = colors.lavender, gui = 'bold' }
}

local progress = {
  'progress',
  color = { fg = colors.orange, gui = 'bold' }
}

local encoding = {
  'encoding',
  fmt = string.upper,
  icon = '',
  color = { fg = colors.green, gui = 'bold' },
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "molokai",
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'dashboard', 'NvimTree', 'Outline' },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { icon },
    lualine_b = {},
    lualine_c = { filetype, filename, diagnostics },
    lualine_x = { diff, branch, lsp, location, progress, encoding },
    lualine_y = { icon },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
