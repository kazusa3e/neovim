require 'lspsaga'.setup {
    code_action_prompt = {
        enable = false
    },
    rename_action_keys = {
        quit = '<ESC>',
        exec = '<CR>'
    }
}

require 'keybindings'.lspsaga()
