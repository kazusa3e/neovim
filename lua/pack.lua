-- Plugin management (Neovim 0.12 built-in vim.pack)
--
-- Plugins are installed to site/pack/core/opt/ by default.
-- They are available immediately after vim.pack.add() call.
-- First install requires a restart.
-- Update with: vim.pack.update() → review → :write to confirm

vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },

  -- tree-sitter parser + query installer (nvim-treesitter fork).
  -- Registry must be on rtp so nvim-treesitter can find parsers.
  { src = 'https://github.com/neovim-treesitter/treesitter-parser-registry' },
  { src = 'https://github.com/neovim-treesitter/nvim-treesitter' },
})
