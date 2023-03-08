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
                ensure_installed = 'all',
            }
        end
    }
}
