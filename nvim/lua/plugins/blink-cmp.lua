local status_ok, blink_cmp = pcall(require, "blink.cmp")
if not status_ok then
  return
end

local icons = require("config.icons")

local kind_icons = {
  Text = icons.kind.Text,
  Method = icons.kind.Method,
  Function = icons.kind.Function,
  Constructor = icons.kind.Constructor,
  Field = icons.kind.Field,
  Variable = icons.kind.Variable,
  Class = icons.kind.Class,
  Interface = icons.kind.Interface,
  Module = icons.kind.Module,
  Property = icons.kind.Property,
  Unit = icons.kind.Unit,
  Value = icons.kind.Value,
  Enum = icons.kind.Enum,
  Keyword = icons.kind.Keyword,
  Snippet = icons.kind.Snippet,
  Color = icons.kind.Color,
  File = icons.kind.File,
  Reference = icons.kind.Reference,
  Folder = icons.kind.Folder,
  EnumMember = icons.kind.EnumMember,
  Constant = icons.kind.Constant,
  Struct = icons.kind.Struct,
  Event = icons.kind.Event,
  Operator = icons.kind.Operator,
  TypeParameter = icons.kind.TypeParameter,
}

blink_cmp.setup({
  keymap = {
    -- set to 'none' to disable the 'default' preset
    preset = "enter",

    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },

    -- disable a keymap from the preset
    ["<C-e>"] = false, -- or {}
    ["<C-c>"] = { "hide" },

    -- show with a list of providers
    ["<C-space>"] = {
      function(cmp)
        cmp.show({ providers = { "snippets" } })
      end,
    },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  signature = { enabled = true },
  completion = {
    ghost_text = {
      enabled = true,
      show_with_menu = true,
    },
    documentation = {
      auto_show = false,
    },
    menu = {
      auto_show = true,
      draw = {
        padding = { 0, 1 }, -- padding only on right side
        components = {
          kind_icon = {
            text = function(ctx)
              return " " .. kind_icons[ctx.kind] .. ctx.icon_gap .. " "
            end,
          },
        },
        columns = {
          { "kind_icon", "label", gap = 1 },
          { "kind" },
        },
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  cmdline = {
    keymap = { preset = "inherit" },
    completion = { menu = { auto_show = false } },
  },
})
