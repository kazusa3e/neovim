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

local ok, nvim_treesitter = pcall(require, "nvim-treesitter")
if not ok then
	-- Install on first use (blocking, needs git + network). The registry must
	-- be on runtimepath so nvim-treesitter can find parsers.
	require("pack").ensure("nvim-treesitter")
	require("pack").ensure("treesitter-parser-registry")
	nvim_treesitter = require("nvim-treesitter")
end

local ok_install, install = pcall(require, "nvim-treesitter.install")
if ok_install and install.get_package_path then
	local fork_runtime = install.get_package_path("runtime")
	if vim.fn.isdirectory(fork_runtime) == 1 then
		vim.opt.rtp:prepend(fork_runtime)
	end
end

-- Parsers to install on startup. :install is a no-op when already present.
-- (Bundled languages are skipped automatically.)
nvim_treesitter.install({
	"c",
	"cpp",
	"go",
	"python",
	"rust",
	"bash",
	"dockerfile",
	"cmake",
	"json",
	"yaml",
	"toml",
})

-- Features are NOT enabled by default; attach per buffer on FileType.
-- Folds are already global via vim.opt.foldexpr (see options.lua).
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local buf = args.buf
		if pcall(vim.treesitter.start, buf) then
			-- tree-sitter indentation (falls back to ftplugin when no parser)
			vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
