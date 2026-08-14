-- plugins/treesitter.lua — nvim-treesitter (MAIN branch, the rewrite)
--
-- main is a full, incompatible rewrite: no `require('nvim-treesitter.configs')`.
-- Requires nvim 0.12+, does NOT lazy-load, and compiles parsers on install
-- (needs a C compiler). Parsers: require('nvim-treesitter').install{...}.
-- Highlighting/indent are enabled per-buffer via a FileType autocmd (main no
-- longer auto-enables them).
--
-- LOST vs master (no main equivalents): incremental_selection (<Tab>/<S-Tab>)
-- and auto_install. New filetypes must be added to `langs` below.

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- main does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      local langs = {
        "lua", "vim", "python", "bash", "go", "gomod", "java",
        "javascript", "typescript", "tsx", "c", "cpp", "rust", "r", "sql",
        "json", "json5", "yaml", "html", "css", "hcl",
        "markdown", "markdown_inline",
        "vimdoc", "query", "comment", "regex", "jsdoc", "cmake", "cuda",
        "gitcommit", "diff",
      }
      -- `install` only exists on the main branch. Until lazy actually checks
      -- out main (run `:Lazy sync` after switching the branch field), the still-
      -- installed master build has no install() — guard so config doesn't error.
      local nt = require("nvim-treesitter")
      if type(nt.install) == "function" then
        nt.install(langs) -- async; no-op if already installed
      else
        vim.schedule(function()
          vim.notify(
            "nvim-treesitter: run :Lazy sync to check out the 'main' branch",
            vim.log.levels.WARN
          )
        end)
      end

      -- Enable treesitter highlighting + (experimental) indent per buffer.
      -- jsonc has no dedicated parser on main; route jsonc files to json's parser.
      vim.treesitter.language.register("json", "jsonc")

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
        callback = function(ev)
          if vim.bo[ev.buf].filetype == "dockerfile" then
            return -- treesitter HL was flaky for dockerfile
          end
          -- vim.treesitter.start errors if no parser for this ft → pcall guards.
          if pcall(vim.treesitter.start, ev.buf) then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
