-- Experimental new core UI (ui2 / extui). Neovim 0.12+.
-- Removes most "Press ENTER" prompts and reshapes messages/cmdline.
require("vim._core.ui2").enable()

-- Clipboard (OSC 52: works over SSH, tmux)
vim.g.clipboard = "osc52"

-- Undo: separate dir from vim (different undofile format)
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- 0.11+: default floating-window border
vim.opt.winborder = "rounded"
-- always show sign column (no shifting)
vim.opt.signcolumn = "yes"

-- Folding (tree-sitter powered, built-in since 0.12)
-- 'nofoldenable' is set in ~/.vimrc (shared with Vim).
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Native word-char autocomplete: DISABLED globally in Neovim.
-- 'set autocomplete' stays in ~/.vimrc for plain Vim, but in Neovim its
-- popup (buffer-word sources from 'complete') conflicts with the LSP
-- completion in lsp.lua: while it is visible, vim.lsp.completion's trigger
-- handler bails out (pumvisible() != 0 guard) and the LSP request is never
-- sent. It also produced ghost text under completeopt=preinsert. LSP-driven
-- completion on every word char is set up in lsp.lua instead (VSCode-like),
-- and lsp.lua re-enables 'autocomplete' PER BUFFER as a fallback for buffers
-- that have no completion-capable LSP server (so the menu always pops).
vim.o.autocomplete = false

-- VSCode-style ghost text (Neovim-only completeopt flag; see ~/.vimrc for why
-- it is not in the shared completeopt line): type 's' -> 'std' is shown as
-- ghost text (hl-PreInsert) after the cursor but not written to the buffer;
-- only <Tab>/<C-y> commits. Without it the first candidate is committed as
-- you type, so typing 'td' after 'std' was auto-inserted corrupted the word.
vim.opt.completeopt:append("preinsert")
