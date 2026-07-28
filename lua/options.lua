-- Experimental new core UI (ui2 / extui). Neovim 0.12+.
-- Removes most "Press ENTER" prompts and reshapes messages/cmdline.
require('vim._core.ui2').enable()

-- Clipboard (OSC 52: works over SSH, tmux)
vim.g.clipboard = 'osc52'

-- Undo: separate dir from vim (different undofile format)
vim.opt.undodir = vim.fn.stdpath('state') .. '/undo'

-- 0.11+: default floating-window border
vim.opt.winborder = 'rounded'
-- always show sign column (no shifting)
vim.opt.signcolumn = 'yes'

-- Folding (tree-sitter powered, built-in since 0.12)
-- 'nofoldenable' is set in ~/.vimrc (shared with Vim).
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
