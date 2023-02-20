require 'toggleterm'.setup {
    highlights = {
        NormalFloat = { link = 'CmpNormal' },
        FloatBorder = { link = 'CmpBorder' }
    }
}

require 'keybindings'.toggleterm()
