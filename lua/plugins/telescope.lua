require 'telescope'.setup {
    defaults = {
        default_mappings = {},
        mappings = {
            i = {
                ['<ESC>'] = require 'telescope.actions'.close,
                ['<C-u>'] = require 'telescope.actions'.preview_scrolling_up,
                ['<C-d>'] = require 'telescope.actions'.preview_scrolling_down,
                ['<CR>'] = require 'telescope.actions'.select_default,
                ['<C-s>'] = require 'telescope.actions'.select_horizontal,
                ['<C-v>'] = require 'telescope.actions'.select_vertical,
                ['<C-h>'] = require 'telescope.actions'.select_tab,
                ['<C-t>'] = require 'trouble.providers.telescope'.open_with_trouble,
                ['<C-k>'] = require 'telescope.actions'.move_selection_previous,
                ['<C-j>'] = require 'telescope.actions'.move_selection_next,
                ['<UP>'] = require 'telescope.actions'.move_selection_previous,
                ['<DOWN>'] = require 'telescope.actions'.move_selection_next,
                ['<C-o>'] = function(prompt_bufnr)
                    return require 'telescope.actions.set'.edit(prompt_bufnr, 'silent !open')
                end,
                ['<C-q>'] = require 'telescope.actions'.send_to_qflist
            },
            n = {
                ['<ESC>'] = require 'telescope.actions'.close,
                ['<CR>'] = require 'telescope.actions'.select_default,
                ['k'] = require 'telescope.actions'.move_selection_previous,
                ['j'] = require 'telescope.actions'.move_selection_next,
                ['<C-s>'] = require 'telescope.actions'.select_horizontal,
                ['<C-v>'] = require 'telescope.actions'.select_vertical,
                ['o'] = function(prompt_bufnr)
                    return require 'telescope.actions.set'.edit(prompt_bufnr, 'silent !open')
                end
            }
        },
        layout_config = {
            horizontal = {
                prompt_position = "top",
            },
        },
    },
    pickers = {
        find_files = {
            find_command = {
                'fd',
                '--type',
                'f',
                '--exclude',
                '.git',
                '--exclude',
                'node_modules',
                '--exclude',
                '*.pyc',
            }
        },
        buffers = {
            theme = 'ivy',
            initial_mode = 'normal',
            previewer = false,
            layout_strategy = 'bottom_pane',
            layout_config = { height = 0.3 },
            mappings = {
                n = {
                    ['x'] = require 'telescope.actions'.delete_buffer
                }
            }
        },
        help_tags = {
            theme = 'dropdown',
            previewer = false
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
        }
    }
}

require 'keybindings'.telescope()

require 'telescope'.load_extension('fzf')
