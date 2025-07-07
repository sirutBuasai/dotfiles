local icons = require("config.icons")

return {
  config = {
    level = vim.log.levels.Info,
    icons = {
      error = icons.diagnostics.Error,
      warn = icons.diagnostics.Warning,
      info = icons.diagnostics.Info,
      debug = icons.diagnostics.Debug,
      trace = icons.diagnostics.Trace,
    },
  },
  style = {
    wo = {
      wrap = true,
    },
  },
}
