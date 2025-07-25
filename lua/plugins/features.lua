return {
    -- finder
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim',                    lazy = true },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
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
            { 'gp',         '<cmd>Telescope lsp_document_symbols<cr>' },
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
                            ['<C-t>'] = require 'trouble.sources.telescope'.open,
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
                            ['<C-t>'] = require 'trouble.sources.telescope'.open,
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
                            -- 'fd', '--type', 'f', '--exclude', '.git', '--exclude', 'node_modules', '--exclude', '*.pyc',
                            'rg', '--files', '--sortr=modified'
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
            require 'nvim-tree'.setup {
                update_cwd = true,
                sync_root_with_cwd = true
            }
        end
    },

    -- diffview
    {
        'sindrets/diffview.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
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
            { '<c-q>', '<cmd>ToggleTerm direction=float<cr>', mode = 'i' },
            { '`',     '<c-\\><c-n>',                         mode = 't' },
            { '<leader>gg', function()
                local Terminal = require('toggleterm.terminal').Terminal
                local lazygit  = Terminal:new({ cmd = 'lazygit', hidden = true, direction = 'float' })
                lazygit:toggle()
            end },
        },
        config = function()
            require 'toggleterm'.setup {
                highlights = {
                    NormalFloat = { link = 'CmpNormal' },
                    FloatBorder = { link = 'CmpBorder' },
                    Normal = { link = 'Normal' },
                }
            }
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
    },

    -- notes
    {
        'epwalsh/obsidian.nvim',
        version = '*',
        lazy = true,
        keys = {
            { '<leader>nd', '<cmd>ObsidianToday<cr>' },
            { '<leader>nn', '<cmd>ObsidianNew<cr>' },
            { '<leader>nt', '<cmd>ObsidianTags<cr>' },
            { '<leader>nf', '<cmd>ObsidianQuickSwitch<cr>' },
            { '<leader>nF', '<cmd>ObsidianSearch<cr>' },
            { '<leader>nb', '<cmd>ObsidianBacklinks<cr>' },
            { '<leader>no', '<cmd>ObsidianTOC<cr>' },
            { '<leader>nc', '<cmd>ObsidianToggleCheckbox<cr>' },
            { '<leader>nr', function()
                local name = vim.fn.input("Note name: ")
                vim.cmd(string.format("ObsidianRename %s", name))
            end },
            {
                '<leader>ne',
                function()
                    vim.cmd [[tcd ~/Rei]]
                    vim.cmd [[NvimTreeOpen]]
                end
            },
            {
                '<leader>nE',
                function()
                    vim.cmd [[tcd ~/Rei]]
                    vim.cmd [[NvimTreeFindFile]]
                end
            },
        },
        ft = "markdown",
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-tree.lua'
        },
        opts = {
            workspaces = {
                {
                    name = 'Rei',
                    path = '~/Rei'
                }
            },
            daily_notes = {
                folder = 'Journal'
            },
            completion = {
                nvim_cmp = true
            },
            disable_frontmatter = true,
            note_id_func = function(title)
                return title
            end,
            mappings = {
                ["gd"] = {
                    action = function() return require("obsidian").util.smart_action() end,
                    opts = { noremap = false, expr = true, buffer = true },
                }
            },
            ui = {
                checkboxes = {
                    [" "] = { char = "󰄰", hl_group = "ObsidianTodo" },
                    ["/"] = { char = "󰪟", hl_group = "ObsidianTilde" },
                    ["x"] = { char = "󰗠", hl_group = "ObsidianDone" },
                    ["?"] = { char = "󰋗", hl_group = "ObsidianRightArrow" },
                    ["-"] = { char = "󰅙", hl_group = "ObsidianRightArrow" },
                }
            }
        },
    },

    -- trouble
    {
        'folke/trouble.nvim',
        cmd = 'Trouble',
        keys = {
            -- { 'gD', '<cmd>Trouble diagnostics toggle<cr>' },
            -- { 'gl', '<cmd>Trouble lsp toggle<cr>' },
            -- { 'go', '<cmd>Trouble symbols toggle<cr>' },
            -- { 'go', '<cmd>Trouble qflist toggle<cr>' },
            -- { 'gr', function()
            --     local trouble = require 'trouble'
            --     if trouble.is_open("lsp_references") then
            --         trouble.refresh('lsp_references')
            --     else
            --         trouble.open('lsp_references')
            --     end
            -- end },
        },
        opts = {
            auto_refresh = true
        },
        config = function(_, opts)
            local trouble = require 'trouble'
            trouble.setup(opts)
            local function open_or_update(action)
                if trouble.is_open(action) then
                    trouble.refresh(action)
                else
                    trouble.open(action, { refresh = false })
                end
            end
            -- TODO: refresh on only special modes
            vim.keymap.set('n', 'gD', '<cmd>Trouble diagnostics toggle<cr>')
            vim.keymap.set('n', 'gq', '<cmd>Trouble qflist toggle<cr>')
            vim.keymap.set('n', 'go', '<cmd>Trouble symbols toggle<cr>')
            vim.keymap.set('n', 'gr', function() open_or_update('lsp_references') end)
            vim.keymap.set('n', 'gl', function() open_or_update('lsp') end)
        end
    },

    {
        'tpope/vim-markdown',
        config = function()
            vim.g.markdown_fenced_languages = {
                'html', 'python', 'cpp', 'c', 'bash=sh', 'shell=sh'
            }
            vim.g.markdown_syntax_conceal = 0
            vim.g.markdown_minlines = 100
        end
    },

    -- todo highlight
    {
        'folke/todo-comments.nvim',
        keys = {
            { ']t', function() require 'todo-comments'.jump_next() end },
            { '[t', function() require 'todo-comments'.jump_prev() end }
        },
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {}
    },

}
