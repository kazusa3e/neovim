setlocal foldmethod=expr
setlocal conceallevel=2
let g:vim_markdown_math = 1

nnoremap gd <CMD>lua vim.lsp.buf.definition()<CR>
