-- plugins/colorizer.lua — catgoose/nvim-colorizer.lua
--
-- Maintained successor to NvChad/nvim-colorizer.lua (NvChad's repo now serves
-- catgoose's docs). Same setup() API. We use INLINE virtual-text swatches: a
-- ■ in the color's hue is shown right before the value, instead of
-- background-coloring the text. Highlights hex + named colors in all files.

return {
  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local icons = require("config.icons")
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          names = true, -- highlight named colors (red, blue, ...) everywhere
          RGB = true, -- #RGB
          RRGGBB = true, -- #RRGGBB
          RRGGBBAA = false,
          rgb_fn = false, -- CSS rgb()/rgba()
          hsl_fn = false, -- CSS hsl()/hsla()
          css = false,
          css_fn = false,
          tailwind = false,
          -- inline swatch instead of background highlight:
          mode = "virtualtext",
          virtualtext = icons.ui.Square,
          virtualtext_inline = true,
        },
        buftypes = {},
      })
    end,
  },
}
