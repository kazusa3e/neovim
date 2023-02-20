require 'nvim-tree'.setup {
    git = {
        enable = true,
        ignore = false
    },
    diagnostics = {
        enable = false
    },
    filters = {
        custom = { '.git', '.DS_Store' },
        exclude = { '.gitignore' }
    },
    view = {
        hide_root_folder = true,
        mappings = {
            custom_only = true,
            list = {
                { key = { '<CR>' }, action = 'edit' },
                { key = { 'R' }, action = 'refresh' },
                { key = { 'n' }, action = 'create' },
                { key = { 'x' }, action = 'remove' },
                { key = { 'r' }, action = 'rename' },
                { key = { 'o' }, action = 'system_open' },
                { key = { '=' }, action = 'collapse_all' },
                { key = { '|' }, action = 'vsplit' },
                { key = { '\\' }, action = 'split' }
            }
        }
    },
    renderer = {
        icons = {
            glyphs = {
                default = '',
                symlink = '',
                folder = {
                    default = '',
                    empty = '',
                    symlink = '',
                    open = '',
                    empty_open = '',
                    symlink_open = ''
                },
                git = {
                    unstaged = '',
                    staged = '',
                    unmerged = '',
                    renamed = '',
                    untracked = '',
                    deleted = '',
                    ignored = ''
                }
            },
        },
        highlight_git = true
    }
}

require 'keybindings'.nvim_tree()
