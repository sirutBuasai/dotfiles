local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

local ensure_servers = {
  "bash",
  "c",
  "cmake",
  "comment",
  "cpp",
  "css",
  "cuda",
  "dockerfile",
  "go",
  "hcl",
  "html",
  "jsdoc",
  "javascript",
  "java",
  "json",
  "json5",
  "jsonc",
  "lua",
  "markdown",
  "python",
  "r",
  "regex",
  "rust",
  "sql",
  "typescript",
  "vim",
  "yaml",
}

local ignore_servers = {
  "phpdoc",
}

treesitter_configs.setup({
  ensure_installed = ensure_servers,
  sync_install = false,
  auto_install = true,
  ignore_install = ignore_servers, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "dockerfile" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "" } },
})
