local status_ok, treesitter_textobjects = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

treesitter_textobjects.setup({
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ig"] = "@comment.inner",
        ["ag"] = "@comment.outer",
        ["ic"] = "@conditional.inner",
        ["ac"] = "@conditional.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ["@conditional.outer"] = "v", -- charwise
        ["@function.outer"] = "V", -- linewise
      },
      include_surrounding_whitespace = false,
    },
  },
})
