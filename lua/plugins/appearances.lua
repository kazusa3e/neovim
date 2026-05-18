return {
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        config = function()
            require 'lualine'.setup {
                options = {
                    theme = 'auto',
                    component_separators = '',
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = { 'NvimTree' },
                    globalstatus = true
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = {
                        { 'filename', path = 1, symbols = { modified = '?', readonly = '!', unnamed = '*' } },
                    },
                    lualine_c = {
                        {
                            'diagnostics',
                            symbols = { error = '󰅙 ', warn = '󰀪 ', info = '󰋽 ', hint = '󰌶 ' },
                        },
                    },
                    lualine_x = {
                        { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } },
                        { 'fileformat', symbols = { unix = 'LF', dos = 'CRLF', mac = 'LF' } },
                    },
                    lualine_y = {
                        'lsp_status'
                    },
                    lualine_z = {
                        { 'branch', icon = '' },
                        'location'
                    }
                }
            }
        end
    },

    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        keys = {
            { '<leader>gd', '<cmd>Gitsigns preview_hunk<cr>', desc = 'Preview hunk' },
            { '<leader>gr', '<cmd>Gitsigns reset_hunk<cr>',   desc = 'Reset hunk' },
            { '<leader>gR', '<cmd>Gitsigns reset_buffer<cr>', desc = 'Reset buffer' },
            { '<leader>ga', '<cmd>Gitsigns stage_hunk<cr>',   desc = 'Stage hunk' },
            { '<leader>gA', '<cmd>Gitsigns stage_buffer<cr>', desc = 'Stage buffer' },
            { '[g',         '<cmd>Gitsigns prev_hunk<cr>',    desc = 'Previous hunk' },
            { ']g',         '<cmd>Gitsigns next_hunk<cr>',    desc = 'Next hunk' },
        },
        config = function()
            require 'gitsigns'.setup {
                numhl = true,
                signcolumn = false,
                word_diff = false,
                current_line_blame = true,
                current_line_blame_opts = {
                    virtual_text = true,
                    virtual_text_pos = 'eol',
                    delay = 200
                }
            }
            vim.api.nvim_set_hl(0, 'GitSignsAddNr', { link = 'GitSignsAdd' })
            vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'GitSignsChange' })
            vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'GitSignsDelete' })
        end,
    },

    {
        'rrethy/vim-illuminate',
        config = function()
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#8c00ff" })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#8c00ff" })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#8c00ff" })
        end
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        enabled = true,
        opts = {
            render_modes = { 'n', 'c', 't', 'i' },
            checkbox = {
                custom = {
                    in_question = { raw = '[?]', rendered = '󰟶 ', highlight = 'DiagnosticSignInfo', scope_highlight = nil },
                    cancelled = { raw = '[-]', rendered = '󰅖 ', highlight = 'DiagnosticSignHint', scope_highlight = nil },
                    in_progress = { raw = '[/]', rendered = '󰚭 ', highlight = 'DiagnosticSignWarn', scope_highlight = nil },
                }
            }
        }
    }
}
