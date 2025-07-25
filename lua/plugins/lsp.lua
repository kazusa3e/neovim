return {
    -- lspconfig
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            vim.diagnostic.config {
                -- virtual_text = {
                --     prefix = '',
                --     current_line = false
                -- },
                virtual_lines = {
                    current_line = true
                }
            }

            vim.lsp.config['lua-language-server'] = require 'lang/lua_ls'

            vim.lsp.enable('clangd')
            vim.lsp.enable('rust_analyzer')
            vim.lsp.enable('pyright')
            vim.lsp.enable('ts_ls')
            vim.lsp.enable('lua_ls')

            vim.lsp.enable('dockerls')
            vim.lsp.enable('docker_compose_language_service')

            vim.lsp.enable('bashls')
        end,
        keys = {
            { 'gd', function() vim.lsp.buf.definition() end },
            { 'gh', function() vim.lsp.buf.hover { border = 'solid' } end },
            { 'gR', function() vim.lsp.buf.rename() end },
            { 'g.', function() vim.lsp.buf.code_action() end },
            { 'gf', function() vim.lsp.buf.format { async = true } end },

            { 'gi', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end },
        }
    },

    -- mason
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        config = function()
            require 'mason'.setup {}
        end
    }
}
