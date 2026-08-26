-- LSP configuration (Neovim 0.12 native API, no nvim-lspconfig).
-- Each server is defined from scratch with cmd/filetypes/root_markers.
-- Keep root_markers explicit so attach behavior is visible (a hidden
-- global root_markers was the source of past cpp-completion bugs).

-- Diagnostics: minimal — signs + underline only, hover or CursorHold for detail
vim.diagnostic.config({
	virtual_text = false,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
	float = {
		border = "rounded",
		source = "if_many",
	},
})

local diagnostic_group = vim.api.nvim_create_augroup("LspDiagnostics", { clear = true })

-- Auto-show diagnostic float on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
	group = diagnostic_group,
	callback = function()
		vim.diagnostic.open_float(nil, {
			focusable = false,
			scope = "cursor",
			border = "rounded",
			source = "if_many",
		})
	end,
})

-- Inlay hints
vim.lsp.inlay_hint.enable(true)

-- Code lens
vim.lsp.codelens.enable(true)

-- Server definitions (no nvim-lspconfig).
-- root_markers: nested lists are equal-priority alternatives (any match
-- attaches); see :help vim.lsp.Config.

vim.lsp.config["clangd"] = {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--function-arg-placeholders=0",
	},
	filetypes = { "c", "cpp" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"configure.ac",
		"CMakeLists.txt",
		"CMakePresets.json",
		"Makefile",
		".git",
	},
}

vim.lsp.config["gopls"] = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod" },
	root_markers = { "go.mod", ".git" },
	settings = {
		gopls = {
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
}

vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		{ ".emmyrc.json", ".luarc.json", ".luarc.jsonc" },
		{ ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml" },
		{ ".git" },
	},
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
			telemetry = { enable = false },
		},
	},
}

vim.lsp.config["rust_analyzer"] = {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "rust-project.json", ".git" },
}

vim.lsp.config["bashls"] = {
	cmd = { "bash-language-server", "start" },
	filetypes = { "bash", "sh" },
	root_markers = { ".git" },
}

vim.lsp.config["cmake"] = {
	cmd = { "cmake-language-server" },
	filetypes = { "cmake" },
	root_markers = { "CMakeLists.txt", "CMakePresets.json", "CMakeLists.txt.in", ".git" },
}

-- ty: Astral's fast Python type checker + language server (Rust).
-- Started with `ty server`. Configure via settings.ty.*
-- (see https://docs.astral.sh/ty/configuration/).
vim.lsp.config["ty"] = {
	cmd = { "ty", "server" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
}

vim.lsp.config["nixd"] = {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = "import <nixpkgs> { }",
			},
			formatting = {
				command = { "nixfmt" },
			},
		},
	},
}

-- Enable language servers
vim.lsp.enable({
	"clangd",
	"gopls",
	"lua_ls",
	"rust_analyzer",
	"bashls",
	"cmake",
	"ty",
	"nixd",
})
