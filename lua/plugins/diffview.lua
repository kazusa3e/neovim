require 'diffview'.setup {
    keymaps = {
        file_panel = {
            ['L'] = false,
            ['x'] = require 'diffview/actions'.toggle_stage_entry,
            ['o'] = require 'diffview/actions'.goto_file_tab
        },
        view = {
            ['o'] = require 'diffview/actions'.goto_file_tab
        }
    },
    file_panel = {
        listing_style = 'list'
    }
}

require 'keybindings'.diffview()
