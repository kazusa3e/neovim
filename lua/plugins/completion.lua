return {
    {
        'saghen/blink.cmp',
        version = '1.*',
        dependencies = {
            'saghen/blink.compat',
            {
                'L3MON4D3/LuaSnip',
                version = '2.*',
                config = function()
                    local vscode_snippets = vim.fn.expand '~/Work/vscode_settings/profiles/main/data/snippets'
                    if vim.uv.fs_stat(vscode_snippets) then
                        require 'luasnip.loaders.from_vscode'.lazy_load { paths = { vscode_snippets } }
                    end
                end,
            },
        },
        opts_extend = { 'sources.default' },
        opts = {
            keymap = {
                preset = 'super-tab',
                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },
                ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono',
                kind_icons = {
                    Text = '󰉿',
                    Method = '󰆧',
                    Function = '󰊕',
                    Constructor = '',
                    Field = '󰜢',
                    Variable = '󰀫',
                    Class = '󰠱',
                    Interface = '',
                    Module = '',
                    Property = '󰜢',
                    Unit = '󰑭',
                    Value = '󰎠',
                    Enum = '',
                    Keyword = '󰌋',
                    Snippet = '',
                    Color = '󰏘',
                    File = '󰈙',
                    Reference = '󰈇',
                    Folder = '󰉋',
                    EnumMember = '',
                    Constant = '󰏿',
                    Struct = '󰙅',
                    Event = '',
                    Operator = '󰆕',
                    TypeParameter = '󰊄',
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            snippets = { preset = 'luasnip' },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
            },
            signature = { enabled = true },
            cmdline = {
                enabled = true,
                keymap = {
                    preset = 'default',
                    ['<Up>'] = { 'select_prev', 'fallback' },
                    ['<Down>'] = { 'select_next', 'fallback' },
                },
                completion = { menu = { auto_show = true } },
                sources = function()
                    local type = vim.fn.getcmdtype()
                    if type == '/' or type == '?' then
                        return { 'buffer' }
                    end
                    return { 'path', 'cmdline', 'buffer' }
                end,
            },
            fuzzy = { implementation = 'prefer_rust_with_warning' },
        },
    },
}
