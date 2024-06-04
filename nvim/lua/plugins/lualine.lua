local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local icons = require("user.icons")

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local colors = {
  white = "#FFFFFF",
  darkgray = "#202328",
  lightgray = "#BBC2CF",
  lavender = "#7070F0",
  orange = "#FD971F",
}

local separator = {
  function()
    return icons.ui.ThickSeparator
  end,
  padding = { left = 0, right = 1 },
}

local filetype = {
  "filetype",
  icon = {
    align = "right",
  },
  icon_only = true,
}

local filename = {
  "filename",
  path = 1,
  color = { fg = colors.lightgray, gui = "bold" },
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "info", "hint" },
  symbols = {
    error = icons.diagnostics.Error .. " ",
    warn = icons.diagnostics.Warning .. " ",
    info = icons.diagnostics.Info .. " ",
    hint = icons.diagnostics.Hint .. " ",
  },
  colored = true,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = true,
  symbols = {
    added = icons.git.Add .. " ",
    modified = icons.git.Mod .. " ",
    removed = icons.git.Remove .. " ",
  },
  cond = hide_in_width,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = icons.git.Branch,
  color = { fg = colors.orange },
}

local lsp = {
  function()
    local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
    if #buf_clients == 0 then
      return "no active lsp"
    end

    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    for _, client in pairs(buf_clients) do
      table.insert(buf_client_names, client.name)
    end

    local unique_client_names = table.concat(buf_client_names, ", ")
    local msg = string.format("[%s]", unique_client_names)
    return msg
  end,
  icon = icons.ui.Comment,
  color = { fg = colors.white, gui = "bold" },
}

local location = {
  "location",
  padding = { left = 0, right = 1 },
  color = { fg = colors.lavender, gui = "bold" },
}

local progress = {
  "progress",
  color = { fg = colors.orange, gui = "bold" },
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "molokai",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { separator },
    lualine_b = {},
    lualine_c = { filetype, filename, branch, diff },
    lualine_x = { lsp, diagnostics, location, progress },
    lualine_y = { separator },
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
