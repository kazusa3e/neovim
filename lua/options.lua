vim.cmd [[ source ~/.vimrc ]]

-- global statusline
vim.opt.laststatus = 3
vim.opt.showmode = false

-- disable nvim intro
-- vim.opt.shortmess:append 'sI'

-- disable backup files
vim.opt.backup = false
vim.opt.swapfile = false

-- enable persistent redo
vim.opt.undofile = true

-- FIX: disable continuous comment
vim.cmd [[ autocmd FileType * set formatoptions-=cro ]]

-- disable mouse support
vim.opt.mouse = ''
