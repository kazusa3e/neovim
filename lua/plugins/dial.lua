require 'dial.config'.augends:register_group {
    default = {
        -- numbers
        require 'dial/augend'.integer.alias.binary,
        require 'dial/augend'.integer.alias.octal,
        require 'dial/augend'.integer.alias.decimal,
        require 'dial/augend'.integer.alias.hex,
        -- boolean
        require 'dial/augend'.constant.alias.bool,
        require 'dial/augend'.constant.new { elements = { '||', '&&' }, word = true },
        require 'dial/augend'.constant.new { elements = { 'or', 'and' }, word = true },
        require 'dial/augend'.constant.new { elements = { 'True', 'False' }, word = true },
        -- alphabets
        require 'dial/augend'.constant.alias.alpha,
        require 'dial/augend'.constant.alias.Alpha,
        -- dates
        require 'dial/augend'.date.alias["%Y/%m/%d"],
        require 'dial/augend'.date.alias["%Y-%m-%d"],
        -- misc
        require 'dial/augend'.misc.alias.markdown_header
    }
}

require 'keybindings'.dial()
