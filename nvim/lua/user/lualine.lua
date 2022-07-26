local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local colors = {
  darkgray  = '#202328',
  lightgray = '#BBC2CF',
  green     = '#A6E22E',
  violet    = '#7070F0',
  orange    = '#FD971F',
}

local mode = {
  "mode",
  fmt = function(str)
    return " " .. str
  end,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local filename = {
  "filename",
  color = { fg = colors.lightgray, gui = 'bold' }
}

local location = {
  "location",
  color = { fg = colors.violet }
}

local lsp = {
 function()
    local msg = 'No Active Lsp'
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
  icon = ':',
  color = { fg = '#ffffff', gui = 'bold' }
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  cond = hide_in_width
}

local filetype = {
  "filetype",
  icons_enabled = true,
  icon = nil,
  color = { fg = colors.green }
}

local progress = {
  'progress',
  color = { fg = colors.lightgray, gui = 'bold' }
}

local encoding = {
  'encoding',
  fmt = string.upper,
  color = { fg = colors.darkgray, gui = 'bold' },
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = '' },
    disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = { branch, diagnostics },
    lualine_c = { filename, location },
    lualine_x = { diff, filetype, lsp, progress },
    lualine_y = {},
    lualine_z = { encoding },
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
