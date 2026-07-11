-- Clipboard (OSC 52: works over SSH, tmux)
vim.g.clipboard = 'osc52'

-- Undo: separate dir from vim (different undofile format)
vim.opt.undodir = vim.fn.stdpath('state') .. '/undo'

-- 0.11+: default floating-window border
vim.opt.winborder = 'rounded'
-- always show sign column (no shifting)
vim.opt.signcolumn = 'yes'

-- Folding (tree-sitter powered, built-in since 0.12)
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldenable = false

-- disable continuation of comments in new lines
vim.opt.formatoptions:remove('r')
