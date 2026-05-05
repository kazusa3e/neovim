return {
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require 'nvim-autopairs'.setup {}
        end
    },

    {
        'tpope/vim-surround',
        event = { 'BufReadPost', 'BufNewFile' },
        keys = {
            { 's', 'ys', remap = true, mode = { 'n' }, desc = 'Surround' },
            { 's', 'S',  remap = true, mode = { 'x' }, desc = 'Surround visual' },
        },
    },

    {
        'junegunn/vim-easy-align',
        keys = {
            { 'ga', '<Plug>(EasyAlign)',           desc = 'Align' },
            { 'ga', '<Plug>(EasyAlign)', mode = 'x', desc = 'Align' },
        }
    },
}
