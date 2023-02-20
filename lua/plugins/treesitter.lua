require 'nvim-treesitter.configs'.setup {
    ensure_installed = 'all',
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'markdown' }
    },
    indent = {
        enable = true
    },
    textobjects = {
        swap = false,
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            }
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_previous_start = {
                ['[c'] = '@class.outer',
                ['[f'] = '@function.outer'
            },
            goto_next_start = {
                [']c'] = '@class.outer',
                [']f'] = '@function.outer'
            },
        }
    }
}

require 'treesitter-context'.setup {
    enable = true,
    patterns = {
        default = {
            'class', 'function', 'method', 'for', 'while', 'if', 'switch', 'case',
        }
    }
}
