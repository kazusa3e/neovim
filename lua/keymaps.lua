-- Editor keymaps
-- (vim-shared maps are in ~/.vimrc; plugin maps in their respective files)

-- Comment operator: q → gc (tree-sitter aware, builtin)
vim.keymap.set("n", "qq", "gcc", { remap = true, desc = "Comment line" })
vim.keymap.set("v", "q", "gc", { remap = true, desc = "Comment selection" })

-- LSP keymaps (no default bindings; these are global since they no-op without a server)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: go to definition" })
vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "LSP: hover" })
-- TODO: references
