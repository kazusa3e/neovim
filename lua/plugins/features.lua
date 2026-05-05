return {
    -- snacks: picker + explorer + terminal
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,

        -- @type snacks.Config
        opts = {
            picker = {
                enabled = true,
                -- matcher = {
                --     fuzzy = true,
                --     smartcase = true,
                --     filename_bonus = true,
                -- },
                -- layout = {
                --     preset = 'default',
                --     cycle = true,
                -- },
                sources = {
                    explorer = {
                        --         hidden = true,
                        --         ignored = true,
                        --         tree = true,
                        git_status = true,
                        follow_file = true,
                        --         focus = 'list',
                        --         auto_close = false,
                        --         jump = { close = false },
                        --         layout = { preset = 'sidebar' },
                    },
                    --     grep = {
                    --         hidden = true,
                    -- },
                },
            },
            explorer = {
                enabled = true,
                replace_netrw = true,
            },
            terminal = {
                enabled = true,
                win = {
                    wo = {
                        number = false,
                        relativenumber = false,
                        signcolumn = 'no',
                    },
                },
            },
        },
        keys = {

            -- picker
            { '<c-p>',      function() Snacks.picker.files() end,                                               desc = 'Smart Find Files' },
            { '<leader>/',  function() Snacks.picker.grep() end,                                                desc = 'Live grep' },

            -- explorer
            { '<leader>e',  function() Snacks.explorer() end,                                                   desc = 'Explorer' },

            { "<leader>fg", function() Snacks.picker.git_files() end,                                           desc = "Find Git Files" },
            { "<leader>fp", function() Snacks.picker.projects() end,                                            desc = "Projects" },
            { "<leader>fr", function() Snacks.picker.recent() end,                                              desc = "Recent" },
            { "<leader>fc", function() Snacks.picker() end,                                                     desc = "Find Files" },

            -- lsp
            { 'go',         function() Snacks.picker.lsp_symbols() end,                                         desc = 'LSP symbols' },
            { "gO",         function() Snacks.picker.lsp_workspace_symbols() end,                               desc = "LSP Workspace Symbols" },
            { 'grr',        function() Snacks.picker.lsp_references() end,                                      desc = 'LSP references' },

            -- terminal
            { '<c-q>',      function() Snacks.terminal.toggle(nil, { win = { position = 'float' } }) end,       mode = { 'n', 't', 'i' },      desc = 'Float terminal' },
            { '<leader>gg', function() Snacks.terminal.toggle('lazygit', { win = { position = 'float' } }) end, desc = 'Lazygit' },

            -- diagnostics
            { 'gq',         function() Snacks.picker.diagnostics() end,                                         desc = 'Diagnostics' },
        },
    },

    -- TODO:
    {
        'folke/todo-comments.nvim',
        keys = {
            { '<leader>t', function() Snacks.picker.grep { search = 'TODO|FIXME|HACK|PERF|NOTE|WARNING|ERROR|OPTIM|FIX|BUG|ISSUE|WARN|INFO|DBG' } end, desc = 'Todo comments' },
        },
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            signs = false,
            keywords = {
                ERROR = {
                    color = 'error',
                    alt = { 'ERR', 'BUG', 'ISSUE', 'FIX', 'FIXME' },
                },
                WARN = {
                    color = 'warning',
                    alt = { 'WRN', 'WARNING', 'NOTICE' }
                },
                INFO = {
                    color = 'info',
                    alt = { 'INF', 'NOTE', 'PREF', 'OPTIM' }
                },
                HINT = {
                    color = 'hint',
                    alt = { 'DBG', 'TODO' }
                }
            },
            colors = {
                error = { 'DiagnosticError' },
                warning = { 'DiagnosticWarn' },
                info = { 'DiagnosticInfo' },
                hint = { 'DiagnosticHint' },
            },
            search = {
                command = 'rg',
                pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
            },
            highlight = {
                pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]],
            }
        }
    },

    -- call hierarchy
    {
        'retran/meow.yarn.nvim',
        dependencies = { 'MunifTanjim/nui.nvim' },
        cmd = { 'MeowYarn' },
        keys = {
            { '<leader>ci', '<cmd>MeowYarn call callers<cr>', desc = 'Incoming calls' },
            { '<leader>co', '<cmd>MeowYarn call callees<cr>', desc = 'Outgoing calls' },
        },
    },

    -- code action preview
    {
        'aznhe21/actions-preview.nvim',
        keys = {
            { 'g.', function() require 'actions-preview'.code_actions() end, desc = 'Code actions' }
        }
    },

    -- github copilot
    {
        'github/copilot.vim',
        event = 'InsertEnter',
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.keymap.set('i', '<c-n>', 'copilot#Accept("<CR>")',
                { expr = true, silent = true, noremap = true, replace_keycodes = false, desc = 'Accept Copilot' })
            vim.g.copilot_filetypes = {
                ['*'] = true,
                ['markdown'] = false,
            }
        end
    },

    {
        'dnlhc/glance.nvim',
        cmd = 'Glance',
        keys = {
            { "grl", '<cmd>Glance references<cr>', desc = 'LSP references' },
        }
    }
}
