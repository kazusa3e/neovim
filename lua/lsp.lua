-- LSP configuration (Neovim 0.12 native API + nvim-lspconfig v2)

-- Global defaults (lowest priority, merged before per-server configs)
vim.lsp.config('*', {
    root_markers = { '.git' },
})

-- Diagnostics: minimal — signs + underline only, hover or CursorHold for detail
vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN]  = 'W',
            [vim.diagnostic.severity.INFO]  = 'I',
            [vim.diagnostic.severity.HINT]  = 'H',
        },
    },
    float = {
        border = 'rounded',
        source = 'if_many',
    },
})

-- Auto-show diagnostic float on cursor hold
vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
        vim.diagnostic.open_float(nil, {
            focusable = false,
            scope = 'cursor',
            border = 'rounded',
            source = 'if_many',
        })
    end,
})

-- Inlay hints
vim.lsp.inlay_hint.enable(true)

-- Server-specific settings (override nvim-lspconfig defaults)
vim.lsp.config('clangd', {
    cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--completion-style=detailed',
        '--function-arg-placeholders=0',
    },
})
vim.lsp.config('gopls', {
    settings = {
        gopls = {
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
})
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.stdpath('config') .. '/lua'] = true,
                },
            },
            telemetry = { enable = false },
        },
    },
})

-- Enable language servers
-- nvim-lspconfig provides default cmd/filetypes/root_markers.
vim.lsp.enable({
    'clangd',
    'gopls',
    'lua_ls',
    'rust_analyzer',
    'bashls',
})

