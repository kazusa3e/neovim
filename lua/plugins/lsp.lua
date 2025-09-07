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
                severity_sort = true,
                virtual_lines = {
                    current_line = true
                }
            }

            -- enable inlay hint be default
            -- WARN: but ikn why rust_analyzer will be failed on startup
            vim.lsp.inlay_hint.enable(true)

            vim.lsp.config['lua-language-server'] = require 'lang/lua_ls'

            local enabled_lsp_servers = {
                'clangd',
                'rust_analyzer',
                'basedpyright',
                'ruff',
                'ts_ls',
                'lua_ls',
                'dockerls',
                'docker_compose_language_service',
                'bashls'
            }
            for _, srv in ipairs(enabled_lsp_servers) do
                vim.lsp.enable(srv)
            end

            -- TODO: it's time to uninstall mason plugin
        end,
        keys = {
            { 'gd', function() vim.lsp.buf.definition() end },
            { 'gh', function() vim.lsp.buf.hover { border = 'solid' } end },
            { 'gR', function() vim.lsp.buf.rename() end },
            { 'g.', function() vim.lsp.buf.code_action() end },
            { 'gf', function() vim.lsp.buf.format { async = true } end },

            { 'gi', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end },
            { 'gu', function()
                local conf = vim.diagnostic.config()
                vim.diagnostic.config {
                    virtual_text = not conf.virtual_text
                }
            end },
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
