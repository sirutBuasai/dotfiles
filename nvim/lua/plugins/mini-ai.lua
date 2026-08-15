return {
  {
    "echasnovski/mini.ai",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    },
    config = function()
      local ai = require("mini.ai")
      ai.setup({
        n_lines = 50,
        search_method = "cover_or_nearest",
        silent = true,
        custom_textobjects = {
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          o = ai.gen_spec.treesitter({
            a = { "@conditional.outer", "@loop.outer" },
            i = { "@conditional.inner", "@loop.inner" },
          }),
          g = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
        },
      })
    end,
  },
}
