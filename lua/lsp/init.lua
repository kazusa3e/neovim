local lspconfig = require 'lspconfig'
local mason = require 'mason'
local mason_config = require 'mason-lspconfig'

mason.setup {}

mason_config.setup {
    automatic_installation = true
}

local caps = require 'cmp_nvim_lsp'.default_capabilities()
-- add snippet support for cmp
caps.textDocument.completion.completionItem.snippetSupport = true
-- add ufo fold support
caps.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, {
    on_attach = function(client, bufnr)
        -- bind keymaps.
        require 'keybindings'.lsp()

        -- set up LSP support for illuminate plugin.
        require 'illuminate'.on_attach(client)

        -- set diagnostic signs.
        vim.diagnostic.config {
            virtual_text = {
                prefix = ''
            },
            severity_sort = true,
            update_in_insert = true
        }
        vim.cmd [[
            sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
            sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
            sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
            sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
        ]]

        -- add border for hover float window.
        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = 'single'
        })
    end,
    capabilities = caps,
})

-- NOTICE: enabled LSP servers are listed here.
-- SEE: <https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers>
lspconfig['lua_ls'].setup {
    settings = require 'lsp/sumneko_lua'
}
lspconfig['pyright'].setup {
    settings = require 'lsp/pyright',
}
lspconfig['jdtls'].setup {
    settings = require 'lsp/jdtls',
    on_init = function(client)
        if client.config.settings then
            client.notify(
                'workspace/didChangeConfiguration',
                { settings = client.config.settings }
            )
        end
    end

}
lspconfig['ltex'].setup {}
lspconfig['tsserver'].setup {}
lspconfig['clangd'].setup {}
lspconfig['texlab'].setup {}
lspconfig['vimls'].setup {}
lspconfig['dockerls'].setup {}
lspconfig['yamlls'].setup {}

require 'lsp/null-ls'
