return {
    -- lspconfig
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = { 'williamboman/mason.nvim' },
        config = function()
            local lspconfig = require 'lspconfig'

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
            }

            lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, {
                on_attach = function(client, bufnr)
                    -- diagnostic
                    vim.diagnostic.config {
                        underline = true,
                        virtual_text = { prefix = '' },
                        severity_sort = true,
                        update_in_insert = true
                    }

                    vim.cmd [[
                        sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
                        sign define DiagnosticSignInfo text= texthl=DiagnosticSignHint linehl= numhl=
                        sign define DiagnosticSignWarn text= texthl=DiagnosticSignHint linehl= numhl=
                        sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
                    ]]

                    -- hover
                    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
                        border = 'single'
                    })
                end,
                capabilities = capabilities
            })


            -- servers
            lspconfig['lua_ls'].setup {
                settings = require 'lang/lua_ls'
            }
        end,
        keys = {
            { 'gh', function() vim.lsp.buf.hover() end },
            { 'g=', function() vim.lsp.buf.format { async = true } end },
            -- { 'g=', function() vim.lsp.buf.format { async = true } end, 'v' },
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
