require 'session_manager'.setup {
    autoload_mode = require 'session_manager/config'.AutoloadMode.Disabled
}

require 'keybindings'.session_manager()
