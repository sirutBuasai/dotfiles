-- plugins/mini-ai.lua — echasnovski/mini.ai
--
-- ONE unified text-object system. Previously mini.ai and treesitter-textobjects
-- both grabbed af/if/ac/ic (and mini's al/il "last" collided with treesitter's
-- loop) — so mini.ai now owns EVERYTHING, pulling structural objects from
-- treesitter queries via gen_spec.treesitter. treesitter-textobjects is kept
-- only as the query provider (no select keymaps of its own).
--
-- Keys:
--   af/if = function     ac/ic = class     ao/io = block (conditional + loop)
--   ag/ig = comment
--   an/in = NEXT variant  al/il = LAST variant   (mini.ai motion prefixes)
--   plus mini defaults: brackets ()[]{}, quotes "'`, tag t, argument a, ? ;
--   with seeking (cover_or_nearest).
--
-- gen_spec.treesitter uses native vim.treesitter (main-branch compatible).

return {
  {
    "echasnovski/mini.ai",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Query provider only: mini.ai reads its `textobjects` queries via
      -- gen_spec.treesitter. Folded in here since nothing else uses it.
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
