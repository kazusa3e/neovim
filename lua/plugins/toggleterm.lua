require 'toggleterm'.setup {
    highlights = {
        NormalFloat = { link = 'CmpNormal' },
        FloatBorder = { link = 'CmpBorder' },
        Normal = { link = 'Normal' },
    }
}

require 'keybindings'.toggleterm()

vim.cmd [[
    autocmd TermOpen * setlocal nonumber
    autocmd TermOpen * startinsert
]]
