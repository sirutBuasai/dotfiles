lua <<EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  ignore_install = { "phpdoc" },
  highlight = { enable = true },
  indent = { enable = true }
}
EOF

