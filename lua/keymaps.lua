-- Editor keymaps
-- (vim-shared maps are in ~/.vimrc; plugin maps in their respective files)

-- Comment operator: q → gc (tree-sitter aware, builtin)
vim.keymap.set("n", "qq", "gcc", { remap = true, desc = "Comment line" })
vim.keymap.set("v", "q", "gc", { remap = true, desc = "Comment selection" })

-- LSP keymaps (no default bindings; these are global since they no-op without a server)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: go to definition" })
vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "LSP: hover" })
-- TODO: references

-- Completion (built-in vim.lsp.completion, no plugin)
--
-- <Tab>      inside popup: accept selected item (<C-y>); else jump to next snippet tabstop
-- Up/Down    cycle selection inside the popup (default keys)
--
-- Triggering lives in lsp.lua: vim.lsp.completion fires on every word char
-- and on server trigger chars (. :: ->), VSCode-like, no native 'autocomplete'
-- (lsp.lua turns it back on per-buffer only when no completion-capable LSP is
-- attached, so the menu pops everywhere).
-- completeopt is "menuone,popup,preinsert" (menuone,popup in ~/.vimrc,
-- preinsert appended in options.lua): the FIRST item is selected (sel=0),
-- and its text is shown as GHOST text (hl-PreInsert) after the typed prefix
-- without being committed -- type 's' for 'std' and only "s" lands in the
-- buffer; <Tab> (or <C-y>) commits the ghost/selected item, <C-e>/<Esc>
-- reverts to just the typed prefix. Up/Down move the selection; <Tab>
-- commits whatever was navigated to.
local function pumvisible()
	return vim.fn.pumvisible() ~= 0
end

-- Manual trigger. The function name varies across 0.11/0.12 (trigger vs get);
-- fall back to omnifunc (<C-x><C-o>) if the API is unavailable.
-- vim.keymap.set('i', '<C-Space>', function()
--     local ok = pcall(function()
--         (vim.lsp.completion.trigger or vim.lsp.completion.get)()
--     end)
--     if not ok then
--         vim.api.nvim_feedkeys(
--             vim.api.nvim_replace_termcodes('<C-x><C-o>', true, false, true), 'n', false)
--     end
-- end, { desc = 'Trigger completion' })

vim.keymap.set("i", "<Tab>", function()
	if pumvisible() then
		return "<C-y>"
	elseif vim.snippet.active({ direction = 1 }) then
		vim.snippet.jump(1)
	else
		return "<Tab>"
	end
end, { expr = true, silent = true, desc = "Accept completion / snippet next" })

vim.keymap.set("i", "<CR>", function()
	if pumvisible() then
		return "<C-e><CR>"
	end
	return "<CR>"
end, { expr = true, silent = true, desc = "Cancel completion ghost / newline" })

-- <Esc> with the popup open would COMMIT the selected item's ghost text into
-- the buffer (the "unselected completion text lingers" bug). Revert it with
-- <C-e> first, then leave insert mode.
vim.keymap.set("i", "<Esc>", function()
	if pumvisible() then
		return "<C-e><Esc>"
	end
	return "<Esc>"
end, { expr = true, silent = true, desc = "Clear completion ghost / leave insert" })
