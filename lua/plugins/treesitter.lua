return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                'romgrk/nvim-treesitter-context'
            }
        },
        build = ':TSUpdate',
        -- event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = { 'lua', 'vim', 'query' },
                auto_install = true,
                sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
                indent = {
                    enable = true
                }
            }
        end
    }
}
