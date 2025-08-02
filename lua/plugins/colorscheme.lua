return {
    {
        "sainnhe/edge",
        enabled = false,
        lazy = false,
        config = function()
            vim.g.edge_enable_italic = false
            vim.cmd.colorscheme('edge')
        end
    },
    {
        "shatur/neovim-ayu",
        lazy = false,
        opts = {
            mirage = true,
            terminal = true
        },
        config = function(opts, _)
            require 'ayu'.setup(opts)
            vim.cmd.colorscheme('ayu-mirage')
        end
    }
}
