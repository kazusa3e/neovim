-- Tree-sitter (Neovim 0.12 built-in + nvim-treesitter fork for parser install)
--
-- Neovim 0.12 ships the tree-sitter engine, vim.treesitter API, highlighter,
-- foldexpr, indentexpr, injections and increment-selection built in.
-- Highlighting needs no plugin.
--
-- Bundled parsers + queries (zero config):
--   c, lua, markdown, markdown_inline, query, vim, vimdoc
-- For any other language two things are required:
--   1. parser   : parser/{lang}.so on runtimepath
--   2. queries  : queries/{lang}/{highlights,folds,indents,injections}.scm
-- Neovim ships queries only for the seven bundled languages.
--
-- nvim-treesitter/nvim-treesitter was archived on 2026-04-03. This uses its
-- official fork (neovim-treesitter org): one :TSInstall fetches both the
-- compiled parser and the matching queries and prepends its install dir to
-- 'runtimepath', so no manual .so / .scm wrangling is needed.
--
--   :TSInstall <lang>    install parser + queries
--   :TSUpdate            update installed parsers/queries
--   :TSStatus            show installed vs latest
--   :checkhealth vim.treesitter
--   :InspectTree         visualise the syntax tree

local pack = require("pack")
local has_nvim_treesitter = pack.ensure("nvim-treesitter")
if has_nvim_treesitter then
	pack.ensure("treesitter-parser-registry")
end

local ok, nvim_treesitter = pcall(require, "nvim-treesitter")

local ok_install, install = pcall(require, "nvim-treesitter.install")
if ok_install and install.get_package_path then
	local fork_runtime = install.get_package_path("runtime")
	if vim.fn.isdirectory(fork_runtime) == 1 then
		vim.opt.rtp:prepend(fork_runtime)
	end
end

-- Install parsers explicitly with :TSInstall. Startup never downloads or
-- compiles parsers, so opening Neovim stays reliable offline.

-- Features are NOT enabled by default; attach per buffer on FileType.
-- Folds are already global via vim.opt.foldexpr (see options.lua).
local group = vim.api.nvim_create_augroup("TreeSitterSetup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = group,
	callback = function(args)
		local buf = args.buf
		if pcall(vim.treesitter.start, buf) then
			-- tree-sitter indentation (falls back to ftplugin when no parser)
			if ok then
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end
	end,
})
