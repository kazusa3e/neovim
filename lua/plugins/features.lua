return {
    -- finder
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim', lazy = true },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
        cmd = 'Telescope',
        keys = {
            { '<leader>f',  '<cmd>Telescope find_files<cr>' },
            { '<leader>F',  '<cmd>Telescope live_grep<cr>' },
            { '<c-p>',      '<cmd>Telescope<cr>' },
            { '<leader>af', '<cmd>Telescope find_files follow=true no_ingore=true hidden=true<cr>' },
            { '<leader>aF', '<cmd>Telescope live_grep follow=true no_ingore=true hidden=true<cr>' },
            { '<leader>ao', '<cmd>Telescope oldfiles<cr>' },
            { '<leader>s',  '<cmd>Telescope buffers<cr>' },
            { '<leader>gs', '<cmd>Telescope git_status<cr>' },
            { '<leader>p',  '<cmd>Telescope lsp_document_symbols<cr>' },
        },
        config = function()
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
                                -- ['<C-t>'] = require 'trouble.providers.telescope'.open_with_trouble,
                                ['<C-k>'] = require 'telescope.actions'.move_selection_previous,
                                ['<C-j>'] = require 'telescope.actions'.move_selection_next,
                                ['<UP>'] = require 'telescope.actions'.move_selection_previous,
                                ['<DOWN>'] = require 'telescope.actions'.move_selection_next,
                                -- ['<C-o>'] = function(prompt_bufnr)
                                --     return require 'telescope.actions.set'.edit(prompt_bufnr, 'silent !open')
                                -- end,
                                -- ['<C-q>'] = require 'telescope.actions'.send_to_qflist
                        },
                        n = {
                                ['<ESC>'] = require 'telescope.actions'.close,
                                ['<CR>'] = require 'telescope.actions'.select_default,
                                ['k'] = require 'telescope.actions'.move_selection_previous,
                                ['j'] = require 'telescope.actions'.move_selection_next,
                                ['<C-s>'] = require 'telescope.actions'.select_horizontal,
                                ['<C-v>'] = require 'telescope.actions'.select_vertical,
                                -- ['o'] = function(prompt_bufnr)
                                --     return require 'telescope.actions.set'.edit(prompt_bufnr, 'silent !open')
                                -- end
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

            require 'telescope'.load_extension('fzf')
        end
    },

    -- file explorer
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            { 'nvim-tree/nvim-web-devicons', lazy = true },
        },
        keys = {
            { '<leader>e', '<cmd>NvimTreeToggle<cr>' },
            { '<leader>E', '<cmd>NvimTreeFindFile<cr>' }
        },
        config = function()
            require 'nvim-tree'.setup {}
        end
    },

    -- diff view
    {
        'sindrets/diffview.nvim',
        keys = {
            { '<leader>gD', '<cmd>DiffviewOpen<cr>' }
        },
        config = function()
            require 'diffview'.setup {
                keymaps = {
                    file_panel = {
                            ['L'] = false,
                            ['x'] = require 'diffview/actions'.toggle_stage_entry,
                            ['o'] = require 'diffview/actions'.goto_file_tab
                    },
                    view = {
                            ['o'] = require 'diffview/actions'.goto_file_tab
                    }
                },
                file_panel = {
                    listing_style = 'list'
                }
            }
        end
    },
    -- float term
    {
        'akinsho/toggleterm.nvim',
        keys = {
            { '<c-q>', '<cmd>ToggleTerm direction=float<cr>' },
            { '<c-q>', '<cmd>ToggleTerm direction=float<cr>', mode = 't' },
            { '`',     '<c-\\><c-n>',                         mode = 't' },
        },
        config = function()
            require 'toggleterm'.setup {
                highlights = {
                    NormalFloat = { link = 'CmpNormal' },
                    FloatBorder = { link = 'CmpBorder' },
                    Normal = { link = 'Normal' },
                }
            }

            vim.cmd [[
                autocmd TermOpen * setlocal nonumber
                autocmd TermOpen * startinsert
            ]]
        end
    },
    -- taboo
    {
        'gcmt/taboo.vim',
        lazy = false,
        keys = {
            { '<leader>hr', function()
                local tabname = vim.fn.input("Tab name: ")
                vim.cmd(string.format("TabooRename %s", tabname))
            end }
        }
    }
}
