return {
    {
        "sainnhe/edge",
        enabled = false,
        lazy = false,
        config = function()
            -- vim.g.edge_enable_italic = false
            vim.cmd [[colorscheme edge]]
        end
    },
    {
        "shatur/neovim-ayu",
        enabled = false,
        event = 'VeryLazy',
        opts = {
            mirage = true,
            terminal = false,
            overrides = {
                Comment = { italic = false },
                CursorLine = { bg = "#000000" },
            }
        },
        config = function(_, opts)
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
        event = 'VeryLazy',
        config = function(_, opts)
            require 'onedarkpro'.setup(opts)
            vim.cmd [[colorscheme onedark]]
        end
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        enabled = true,
        event = 'VeryLazy',
        config = function(_, opts)
            vim.cmd [[colorscheme oxocarbon]]
        end
    }
}
