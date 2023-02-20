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

require 'keybindings'.gitsigns()
