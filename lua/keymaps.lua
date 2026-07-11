-- Editor keymaps
-- (vim-shared maps are in ~/.vimrc; plugin maps in their respective files)

-- Comment operator: q → gc (tree-sitter aware, builtin)
vim.keymap.set('n', 'q', 'gc', { remap = true, desc = 'Comment operator' })
vim.keymap.set('n', 'qq', 'gcc', { remap = true, desc = 'Comment line' })
vim.keymap.set('v', 'q', 'gc', { remap = true, desc = 'Comment selection' })
