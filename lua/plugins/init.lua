-- Plugin toggles. Set to `false` to skip installing/loading a plugin.
local plugins = {
	treesitter = true, -- nvim-treesitter (+ parser registry): highlight/indent/parsers
	completion = true, -- blink.cmp: LSP/path/snippet/buffer completion
	lsp = true, -- native LSP config (no external plugin)
	minidiff = true, -- mini.diff: git diff hunks in the sign column
	surround = true, -- vim-surround: add/delete/change via `s`/`ds`/`cs` (VS Code-style `s`)
	conform = true, -- conform.nvim: external formatters with LSP fallback
	pick = true, -- mini.pick: fuzzy finder (files/buffers/grep)
}

if plugins.treesitter then
	require("treesitter")
end

-- Load completion before LSP so blink.cmp can extend client capabilities.
if plugins.completion then
	require("plugins.blink")
end

if plugins.lsp then
	require("lsp")
end

if plugins.minidiff then
	require("plugins.minidiff")
end

if plugins.surround then
	require("plugins.surround")
end

if plugins.conform then
	require("plugins.conform")
end

if plugins.pick then
	require("plugins.pick")
end
