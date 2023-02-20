vim.cmd [[
    let g:tex_flavor = 'latex'
    let g:vimtex_quickfix_mode = 0
    let g:vimtex_compiler_method = 'latexmk'
    let g:vimtex_view_method = 'skim'
]]

require 'keybindings'.vimtex()
