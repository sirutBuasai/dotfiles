-- plugins/autopairs.lua — auto-close brackets/quotes as you type.

return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter", -- only needed once we start typing
    config = function()
      require("nvim-autopairs").setup({
        -- Treesitter-aware: don't auto-pair inside strings/comments (restored from old config).
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          java = false,
        },
        -- FastWrap: in insert mode press <C-e>, then a hint key, to wrap the
        -- text ahead in the bracket you just opened. Try it; remove if unwanted.
        fast_wrap = {
          map = "<C-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          offset = 0, -- offset from pattern match
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })
    end,
  },
}
