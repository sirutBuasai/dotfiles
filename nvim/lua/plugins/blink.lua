-- plugins/blink.lua — saghen/blink.cmp
--
-- Completion engine. Config restored from your previous setup:
--   • kind-icon two-column menu (icons from config.icons.kind)
--   • signature help enabled
--   • <C-space> shows snippets only
--   • <C-e> = false → freed for autopairs fast-wrap
--   • cmdline completion (menu hidden until asked)
-- Capabilities are also consumed by the LSP layer (lsp.lua).

return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "mikavilpas/blink-ripgrep.nvim", -- project-wide grep completion source
  },
  -- version = "*" pulls the latest tagged release (prebuilt Rust fuzzy binary,
  -- no cargo needed). NOTE: blink v2 is in active development with breaking
  -- changes; pin `version = "1.*"` if you want to stay on the stable v1 line.
  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = function()
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

    return {
      keymap = {
        preset = "enter",
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-e>"] = false, -- disabled so autopairs fast-wrap can use <C-e>
        ["<C-c>"] = { "hide" },
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
          show_with_selection = true,
        },
        documentation = {
          auto_show = false,
        },
        menu = {
          auto_show = true,
          draw = {
            padding = { 0, 1 }, -- right-side padding only
            components = {
              kind_icon = {
                text = function(ctx)
                  -- prefer our custom kind icons; fall back to blink's built-in
                  -- (buffer/path/ripgrep can emit kinds not in our map), and
                  -- guard icon_gap in case the blink API omits it.
                  local icon = kind_icons[ctx.kind] or ctx.kind_icon or ""
                  return " " .. icon .. (ctx.icon_gap or " ") .. " "
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
        default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
        providers = {
          -- Clear LSP's fallback (default {"buffer"}) so buffer/codebase words
          -- show ALONGSIDE LSP results instead of only when LSP returns nothing.
          lsp = { fallbacks = {} },
          -- Project-wide grep completion (needs `rg` on PATH).
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
          },
        },
      },
      cmdline = {
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = false } },
      },
    }
  end,
  opts_extend = { "sources.default" },
}
