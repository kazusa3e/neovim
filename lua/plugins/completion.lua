return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'dmitmel/cmp-cmdline-history',
        'onsails/lspkind-nvim',
        'L3MON4D3/LuaSnip'
    },
    event = 'InsertEnter',
    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'

        cmp.setup {
            completion = { completeopt = 'menu,menuone,noinsert' },
            snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
            sources = cmp.config.sources {
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'buffer' }
            },
            window = {
                documentation = {
                    border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
                    winhighlight = 'Normal:CmpNormal,FloatBorder:CmpBorder,Search:None'
                },
                completion = {
                    border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
                    winhighlight = 'Normal:CmpNormal,FloatBorder:CmpBorder,Search:None'
                }
            },
            formattings = {
                fields = { 'kind', 'abbr', 'menu' },
                format = require 'lspkind'.cmp_format { mode = 'symbol', max_width = 60 }
            },
            mapping = {
                ['<c-u>'] = cmp.mapping.scroll_docs(-4),
                ['<c-d>'] = cmp.mapping.scroll_docs(4),
                ['<up>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then cmp.select_prev_item() else fallback() end
                end, { 'i', 's' }),
                ['<down>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then cmp.select_next_item() else fallback() end
                end, { 'i', 's' }),
                ['<TAB>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then cmp.confirm()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else fallback()
                    end
                end, { 'i', 's' })
            }
        }

        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = 'buffer' } }
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            }, {
                { name = 'cmdline_history' }
            })
        })

        require 'luasnip.loaders.from_snipmate'.load { path = { 'snippets' } }
        require 'luasnip.loaders.from_vscode'.lazy_load()

        -- SEE: <https://github.com/L3MON4D3/LuaSnip/issues/258>
        vim.api.nvim_create_autocmd('ModeChanged', {
            pattern = '*',
            callback = function()
                if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
                    and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
                    and not require('luasnip').session.jump_active
                then
                    require('luasnip').unlink_current()
                end
            end
        })
    end
}
