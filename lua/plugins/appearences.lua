return {
    -- lualine
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        dependencies = {
            'f-person/git-blame.nvim'
        },
        config = function()
            local gitblame = require 'gitblame'
            require 'lualine'.setup {
                options = {
                    theme = 'ayu',
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
                            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                        },
                        {
                            function() return require 'nvim-treesitter'.statusline {} end
                        },
                        {
                            gitblame.get_current_blame_text,
                            cond = gitblame.is_blame_text_available
                        }
                    },
                    lualine_x = {
                        { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } }
                    },
                    lualine_y = {
                        { 'fileformat', symbols = { unix = 'LF', dos = 'CRLF', mac = 'LF' } },
                        'encoding',
                        'filetype',
                        'lsp_status'
                    },
                    lualine_z = {
                        { 'branch', icon = 'שׂ' },
                        'location'
                    }
                }
            }
        end
    },

    -- git signs
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        keys = {
            { '<leader>gd', '<cmd>Gitsigns preview_hunk<cr>' },
            { '<leader>gr', '<cmd>Gitsigns reset_hunk<cr>' },
            { '<leader>gR', '<cmd>Gitsigns reset_buffer<cr>' },
            { '<leader>ga', '<cmd>Gitsigns stage_hunk<cr>' },
            { '<leader>gA', '<cmd>Gitsigns stage_buffer<cr>' },
            { '[g', '<cmd>Gitsigns prev_hunk<cr>' },
            { ']g', '<cmd>Gitsigns next_hunk<cr>' },
        },
        config = function()
            require 'gitsigns'.setup {
                numhl = true,
                signcolumn = false,
                word_diff = false,
                current_line_blame = false,
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

    -- git blame
    {
        'f-person/git-blame.nvim',
        config = function()
            vim.g.gitblame_date_format = '%r'
			vim.g.gitblame_message_when_not_committed = ''
			vim.g.gitblame_display_virtual_text = 0
        end
    },

    -- illuminate
    {
        'rrethy/vim-illuminate'
    }


}
