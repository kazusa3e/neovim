return {
    {
        "sainnhe/edge",
        enabled = false,
        lazy = false,
        config = function()
            vim.g.edge_enable_italic = false
            vim.cmd [[colorscheme edge]]
        end
    },
    {
        "shatur/neovim-ayu",
        enabled = true,
        lazy = false,
        opts = {
            mirage = true,
            terminal = false,
        },
        config = function(opts, _)
            require 'ayu'.setup(opts)
            if os.getenv('USE_THEME') == 'light' then
                vim.cmd [[colorscheme ayu]]
            else
                vim.cmd [[colorscheme ayu-mirage]]
            end
        end
    },
    {
        "olimorris/onedarkpro.nvim",
        enabled = false,
        lazy = false,
        config = function(opts, _)
            require 'onedarkpro'.setup(opts)
            vim.cmd [[colorscheme onedark]]
        end
    }
}
