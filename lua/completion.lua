local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sources = cmp.config.sources {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    },
    window = {
        documentation = {
            -- FIX: trick ways to set padding
            border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
            winhighlight = 'Normal:CmpNormal,FloatBorder:CmpBorder,Search:None'
        },
        completion = {
            -- FIX: trick ways to set padding
            border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
            winhighlight = 'Normal:CmpNormal,FloatBorder:CmpBorder,Search:None'
        }
    },
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = require 'lspkind'.cmp_format {
            mode = 'symbol',
            max_width = 60
        }
    },
    mapping = {
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<UP>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<DOWN>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<TAB>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {'i', 's'})
    }
}

-- hint buffer pattern when search
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- hint cmd when command mode
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- vim.cmd [[ set completeopt=menu,menuone,noselect ]]

require 'luasnip.loaders.from_snipmate'.load { path = { 'snippets' } }
require 'luasnip.loaders.from_vscode'.lazy_load()
