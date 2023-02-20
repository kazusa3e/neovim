require 'trouble'.setup {
    mode = 'document_diagnostics',
    padding = false,
    action_keys = {
        close = {},
        hover = {},
        open_split = { '\\' },
        open_vsplit = { '|' },
    },
    indent_lines = false,
    use_diagnostic_signs = true
}

require 'keybindings'.trouble()
