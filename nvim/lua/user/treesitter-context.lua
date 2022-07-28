require'treesitter-context'.setup{
    enable = true,
    max_lines = 0,
    trim_scope = 'outer',
    patterns = {
        default = {
            'class',
            'function',
            'method',
            -- 'for',
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
        },
        --   rust = {
        --       'impl_item',
        --   },
    },
    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.
    zindex = 20,
    mode = 'cursor',
}
