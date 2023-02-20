require 'glance'.setup {
    preview_win_opts = {
        cursorline = true,
        number = true,
        wrap = false
    },
    theme = {
        enable = false
    },
    hooks = {
        before_open = function(results, open, jump, method)
            if #results == 1 then
                jump(results[1])
            else
                open(results)
            end
        end
    }
}

require 'keybindings'.glance()
