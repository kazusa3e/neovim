require 'Comment'.setup {
    padding = true,
    sticky = false,
    toggler = {
        line = 'qq',
        block = 'QQ'
    },
    opleader = {
        line = 'q',
        block = 'Q'
    },
    extra = {
        above = 'qO',
        below = 'qo',
        eol = 'qa'
    },
    mappings = {
        basic = true,
        extra = true,
    }
}

require 'keybindings'.comment()
