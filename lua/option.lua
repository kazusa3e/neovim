-- ~/.vimrc contains only settings shared between vim and neovim
vim.cmd [[ source $HOME/.vimrc ]]

vim.g.clipboard = 'osc52'
vim.opt.exrc = true

-- comment: q → gc operator, qq → gcc line
vim.keymap.set('n', 'q', 'gc', { remap = true, desc = 'Comment operator' })
vim.keymap.set('n', 'qq', 'gcc', { remap = true, desc = 'Comment line' })
vim.keymap.set('v', 'q', 'gc', { remap = true, desc = 'Comment line' })

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false

vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

-- restore cursor position on reopen
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- vim.opt.fillchars:append("diff:╱")
