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
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldenable = false

-- formatoptions: explicitly enable only the flags we want.
-- formatoptions is buffer-local and gets reset by filetype plugins on
-- FileType/BufEnter, so set the flags in an autocmd instead of once at
-- startup.
vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('formatoptions', { clear = true }),
  callback = function(args)
    -- Only real file buffers, and avoid touching unlisted ones like
    -- quickfix/neovim internals.
    if not vim.api.nvim_buf_is_loaded(args.buf) then return end
    if vim.bo[args.buf].buftype ~= '' then return end
    -- formatoptions is a string option: each flag is a single character.
    -- Keep the flags below in an explicit list (one per line) for clarity,
    -- then join them into the string Neovim expects.
    local flags = {
      't', -- auto-wrap text using 'textwidth'
      'c', -- auto-wrap comments using 'textwidth', inserting the comment leader
      -- 'r', -- auto-insert comment leader after <Enter> (comment continuation)
      -- 'o', -- auto-insert comment leader after o/O (comment continuation)
      'q', -- allow formatting of comments with 'gq'
      'n', -- recognize numbered lists when formatting text
      'l', -- long lines are not broken in insert mode
      'j', -- remove comment leader when joining lines with 'J'
    }
    vim.bo[args.buf].formatoptions = table.concat(flags)
  end,
})

-- Native insert-mode auto-completion (Neovim 0.12+).
-- Fires on word-char typing, pulling from 'complete' sources (buffer etc.).
-- Does NOT drive LSP; LSP trigger chars (., ::) are handled by
-- vim.lsp.completion.enable in lsp.lua.
vim.o.autocomplete = true

-- Completion popup behaviour: always show menu (even single match),
-- don't pre-select the first item, and show docs in a popup window.
vim.opt.completeopt = { 'menuone', 'noselect', 'popup' }

-- 'complete' defines which sources insert-mode completion (and 'autocomplete')
-- draws from, in priority order. Each flag is one source; a suffix "^N" can
-- limit per-source matches to N. See :help 'complete'.
vim.opt.complete = {
  '.',   -- current buffer
  'w^5', -- buffers shown in other windows (limit 5 matches)
  'b^5', -- other loaded buffers listed in the buffer list (limit 5)
  'u^5', -- unloaded buffers listed in the buffer list (limit 5)
  't',   -- tags
  'i',   -- current and included files
  -- 'o',   -- omnifunc (LSP via vim.lsp.omnifunc when a server is attached)
  -- 'k',  -- dictionary
  -- 's',  -- thesaurus
  -- 'F',  -- completefunc / named function
}
