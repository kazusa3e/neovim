return {
    -- lualine
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        config = function()
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
                    lualine_c = { {
                        'diagnostics',
                        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                    } },
                    lualine_x = {
                        { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } }
                    },
                    lualine_y = {
                        { 'fileformat', symbols = { unix = 'LF', dos = 'CRLF', mac = 'LF' } },
                        'encoding',
                        'filetype'
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
            { '<leader>gw', '<cmd>Gitsigns reset_hunk<cr>' },
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
                },
                signs = {
                    add = { numhl = 'GitSignsAddNr' },
                    change = { numhl = 'GitSignsChangeNr' },
                    delete = { numhl = 'GitSignsDeleteNr' }
                }
            }
        end,
    }
}
