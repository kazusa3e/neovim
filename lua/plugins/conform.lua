-- conform.nvim: external formatters with LSP fallback.
-- Installed on first use (see lua/pack.lua).
--
-- Format triggers:
--   <leader>gq (vimrc)  -> gq  -> conform formatexpr (whole buffer)
--   :ConformInfo        -> conform diagnostics

require("pack").ensure("conform.nvim")

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofmt" },
		rust = { "rustfmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		python = { "isort", "black" },
		bash = { "shfmt" },
		sh = { "shfmt" },
		cmake = { "cmake-format" },
		nix = { "nixfmt" },
		json = { "prettierd", "prettier" },
		yaml = { "prettierd", "prettier" },
		markdown = { "prettierd", "prettier" },
	},
	default_format_opts = {
		lsp_format = "fallback",
		timeout_ms = 3000,
	},
	-- format_on_save = { lsp_format = 'fallback', timeout_ms = 500 },
})

vim.api.nvim_create_autocmd({ "FileType", "LspAttach" }, {
	callback = function(ev)
		vim.bo[ev.buf].formatexpr = "v:lua.require('conform').formatexpr()"
	end,
})
