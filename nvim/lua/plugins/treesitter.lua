return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
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
      local nt = require("nvim-treesitter")
      if type(nt.install) == "function" then
        nt.install(langs)
      else
        vim.schedule(function()
          vim.notify(
            "nvim-treesitter: run :Lazy sync to check out the 'main' branch",
            vim.log.levels.WARN
          )
        end)
      end

      -- jsonc has no dedicated parser, route jsonc files to json's parser.
      vim.treesitter.language.register("json", "jsonc")

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
        callback = function(ev)
          if vim.bo[ev.buf].filetype == "dockerfile" then
            return -- treesitter HL was flaky for dockerfile
          end

          if pcall(vim.treesitter.start, ev.buf) then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
