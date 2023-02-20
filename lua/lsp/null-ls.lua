local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then return end

null_ls.setup {
    debug = true,
    sources = {
        null_ls.builtins.completion.spell.with {
            filetypes = { 'tex', 'markdown', 'text' }
        },
        null_ls.builtins.formatting.black.with {
            args = { '--quiet', '-' },
            extra_args = { '--fast', '--skip-string-normalization' }
        },
        -- TODO: more linter
    },
    update_in_insert = false,
}
