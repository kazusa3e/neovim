-- Plugin toggles. Set to `false` to skip installing/loading a plugin.
local plugins = {
	treesitter = true, -- nvim-treesitter (+ parser registry): highlight/indent/parsers
	lsp = true, -- native LSP config (no external plugin)
	minidiff = true, -- mini.diff: git diff hunks in the sign column
	conform = true, -- conform.nvim: external formatters with LSP fallback
}

if plugins.treesitter then
	require("treesitter")
end

if plugins.lsp then
	require("lsp")
end

if plugins.minidiff then
	require("plugins.minidiff")
end

if plugins.conform then
	require("plugins.conform")
end
