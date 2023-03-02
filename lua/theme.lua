vim.o.background = 'light'
local colors = require 'ayu.colors'
colors.generate()
local bg2 = '#e2f4f0'

require 'ayu'.setup {
    overrides = {
        NormalFloat = { bg = bg2 },
        FloatBorder = { bg = bg2, fg = bg2 },
        CmpNormal = { bg = bg2 },
        CmpBorder = { bg = bg2, fg = bg2 },
        TelescopeNormal = { bg = bg2 },
        TelescopeBorder = { bg = bg2, fg = bg2 },
        TelescopeTitle = { bg = colors.accent },
        TelescopePromptBorder = { bg = bg2, fg = bg2 },
        Folded = { bg = bg2 },
        NotePurple = { bg = '#9c27b0', fg = '#ffffff' },
        NoteCyan = { bg = '#00bcd4', fg = '#ffffff' },
        NoteGreen = { bg = '#4caf50', fg = '#ffffff' },
        NoteTodo = { bg = '#03a9f4', fg = '#ffffff' },
        NoteDDL = { bg = '#f44336', fg = '#ffffff' },
        GitSignsCurrentLineBlame = { fg = '#abb0b6' },
        NonText = { fg = colors.bg },
        VertSplit = { bg = colors.bg, fg = colors.markup },
        LspSignatureActiveParameter = { fg = colors.accent },
        Search = { bg = colors.accent, fg = '#fafafa' }
    }
}

require 'ayu'.colorscheme {}

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
            }
        },
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

vim.cmd [[ 
    set guicursor=i:block
    set cursorline
]]

-- Enable True Color support.
--
-- Among of Terminal, TMUX and VIM support needs to support true color.
-- In VIM 8.0+, launch VIM, run `:term` to open terminal then run codes
-- below to check whether it supports `true color`.
--
-- awk 'BEGIN {
--     s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
--     for (colnum = 0; colnum<77; colnum++) {
--         r = 255-(colnum*255/76);
--         g = (colnum*510/76);
--         b = (colnum*255/76);
--         if (g>255) g = 510-g;
--         printf "\033[48;2;%d;%d;%dm", r,g,b;
--         printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
--         printf "%s\033[0m", substr(s,colnum+1,1);
--     }
--     printf "\n";
-- }'
--
-- See <https://gist.github.com/XVilka/8346728> for more information.
vim.cmd [[
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
]]

-- add border for diagnostic float window.
vim.diagnostic.open_float = (function(origin)
    return function(opts)
        local border_color = 'CmpBorder'
        opts.border = {
            { "╔", border_color },
            { "═", border_color },
            { "╗", border_color },
            { "║", border_color },
            { "╝", border_color },
            { "═", border_color },
            { "╚", border_color },
            { "║", border_color },
        }
        return origin(opts)
    end
end)(vim.diagnostic.open_float)
