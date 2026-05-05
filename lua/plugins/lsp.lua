return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            vim.diagnostic.config {
                virtual_text = {
                    prefix = '',
                    current_line = false
                },
                severity_sort = true,
                virtual_lines = {
                    current_line = true
                }
            }

            vim.lsp.inlay_hint.enable(true)
            vim.lsp.log.set_level(vim.log.levels.WARN)

            -- format on save, skip if project disables it
            vim.api.nvim_create_autocmd('BufWritePre', {
                callback = function()
                    if vim.g.format_on_save == false then return end
                    vim.lsp.buf.format { async = false, timeout_ms = 2000 }
                end,
            })

            vim.lsp.enable({
                'clangd', 'rust_analyzer', 'ty', 'lua_ls', 'gopls',
                'dockerls', 'docker_compose_language_service',
                'cmake',
                'bashls',
                'marksman',

            })
        end,
        keys = {
            { 'gd', function() vim.lsp.buf.definition() end,           desc = 'Goto definition' },
            { 'gh', function() vim.lsp.buf.hover() end,                desc = 'Hover' },
            { 'gf', function() vim.lsp.buf.format { async = true } end, desc = 'Format' },
        }
    },
}
