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
			[vim.diagnostic.severity.ERROR] = "E",
			[vim.diagnostic.severity.WARN] = "W",
			[vim.diagnostic.severity.INFO] = "I",
			[vim.diagnostic.severity.HINT] = "H",
		},
	},
	float = {
		border = "rounded",
		source = "if_many",
	},
})

-- Auto-show diagnostic float on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
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

-- LSP-driven completion: VSCode-like, on every word character (not only the
-- server's trigger chars like . :: ->) so candidates pop up as you type an
-- identifier and filter down live. 'autocomplete' stays off for LSP buffers
-- (its popup suppressed these LSP triggers via the pumvisible() guard when
-- both were on); non-LSP buffers get native 'autocomplete' as fallback below.
-- completeopt gains "preinsert" in options.lua so the first candidate is only
-- ghosted, not committed, while typing.
local function word_chars()
	local chars = {}
	for i = 97, 122 do
		table.insert(chars, string.char(i))
	end -- a-z
	for i = 65, 90 do
		table.insert(chars, string.char(i))
	end -- A-Z
	for i = 48, 57 do
		table.insert(chars, string.char(i))
	end -- 0-9
	table.insert(chars, "_")
	return chars
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method("textDocument/completion") then
			local provider = vim.tbl_get(client.server_capabilities, "completionProvider") or {}
			-- Extend the server's trigger chars with plain identifier chars.
			local seen = {}
			for _, ch in ipairs(provider.triggerCharacters or {}) do
				seen[ch] = true
			end
			for _, ch in ipairs(word_chars()) do
				seen[ch] = true
			end
			provider.triggerCharacters = vim.tbl_keys(seen)
			vim.lsp.completion.enable(true, client.id, ev.buf, {
				autotrigger = true,
			})
			-- The native autocomplete popup must NOT overlap the LSP popup
			-- (it swallows the LSP trigger via the pumvisible() guard).
			vim.bo[ev.buf].autocomplete = false
		end
	end,
})

-- ---------------------------------------------------------------------------
-- "Always pop up the completion menu" (VSCode-like):
--
-- * Buffer WITH a completion-capable LSP server: vim.lsp.completion autotriggers
--   on every word char (above). 'autocomplete' stays off for these buffers
--   (setting it here in case the fallback enabled it earlier).
-- * Buffer WITHOUT one (md/txt/json/yaml/...): fall back to the native
--   'autocomplete' buffer-word completion from 'complete' (set in ~/.vimrc),
--   which also pops on every word char.
--
-- 'autocomplete' is a global-local option (buffer-scoped via vim.bo), so each
-- buffer gets its own mode. Changing it mid-typing with an open popup is
-- avoided by skipping when the popup is visible.
-- ---------------------------------------------------------------------------
local function sync_completion_mode(bufnr)
	if vim.fn.pumvisible() ~= 0 then
		return
	end
	-- Skip special buffers (terminal, quickfix, ...): no insert typing there.
	if vim.bo[bufnr].buftype:match("%w") then
		vim.bo[bufnr].autocomplete = false
		return
	end
	local has_lsp = #vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/completion" }) > 0
	vim.bo[bufnr].autocomplete = not has_lsp
end

-- New / reopened buffers
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "FileType" }, {
	callback = function(ev)
		sync_completion_mode(ev.buf)
	end,
})

-- An LSP server attached later: hand the buffer over to LSP completion.
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		sync_completion_mode(ev.buf)
	end,
})

-- No LSP server for this buffer anymore: native autocomplete takes over again.
vim.api.nvim_create_autocmd("LspDetach", {
	callback = function(ev)
		sync_completion_mode(ev.buf)
	end,
})

-- Cover the buffer that was open when this module loaded.
sync_completion_mode(vim.api.nvim_get_current_buf())

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
		"CMakepresets.json",
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
