require 'nvim-surround'.setup {
    keymaps = {
        -- insert mode
        insert = false,

        -- normal mode
        normal = 's',
        normal_cur = 'sil',
        normal_line = false,
        normal_cur_line = false,
        delete = 'ds',
        change = 'cs',

        -- visual mode
        visual = 's',
        visual_line = 'S',
    },
    move_cursor = false,
    indent_lines = false
}
