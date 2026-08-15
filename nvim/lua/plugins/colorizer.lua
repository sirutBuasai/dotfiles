return {
  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local icons = require("config.icons")
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          names = true, -- highlight named colors (red, blue)
          RGB = true, -- #RGB
          RRGGBB = true, -- #RRGGBB
          RRGGBBAA = false,
          rgb_fn = false, -- CSS rgb()/rgba()
          hsl_fn = false, -- CSS hsl()/hsla()
          css = false,
          css_fn = false,
          tailwind = false,
          mode = "virtualtext",
          virtualtext = icons.ui.Square,
          virtualtext_inline = true,
        },
        buftypes = {},
      })
    end,
  },
}
