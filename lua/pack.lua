-- Plugin management (Neovim 0.12 built-in vim.pack)
--
-- Plugins are installed to site/pack/core/opt/ by default.
-- They are available immediately after vim.pack.add() call.
-- First install requires a restart.
-- Update with: vim.pack.update() → review → :write to confirm

vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
})
