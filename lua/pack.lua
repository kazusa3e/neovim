-- Plugin management (Neovim 0.12 built-in vim.pack)
--
-- Plugins are installed to site/pack/core/opt/ by default.
-- Missing plugins from the lockfile are offered at startup and installed only
-- after confirmation. Run :PackInstall to retry or install newly configured plugins.
-- Update with: vim.pack.update() → review → :write to confirm

local M = {}

local SRC = {
	["nvim-treesitter"] = "https://github.com/neovim-treesitter/nvim-treesitter",
	["treesitter-parser-registry"] = "https://github.com/neovim-treesitter/treesitter-parser-registry",

	["mini.diff"] = "https://github.com/nvim-mini/mini.diff",
	["vim-surround"] = "https://github.com/tpope/vim-surround",
	["conform.nvim"] = "https://github.com/stevearc/conform.nvim",
	["mini.pick"] = "https://github.com/nvim-mini/mini.pick",
	["blink.cmp"] = "https://github.com/Saghen/blink.cmp",
	["nvim-autopairs"] = "https://github.com/windwp/nvim-autopairs",
	["edge"] = "https://github.com/sainnhe/edge",
	["toggleterm.nvim"] = "https://github.com/akinsho/toggleterm.nvim",
}

local VERSION = {
	["blink.cmp"] = vim.version.range("1.*"),
}

local function spec(name)
	local src = SRC[name]
	if not src then
		error("pack.ensure: unknown plugin " .. tostring(name))
	end
	return { src = src, name = name, version = VERSION[name] }
end

-- Reconcile the lockfile once. An empty spec list avoids registering plugins
-- before their individual configs load; missing plugins still require consent.
vim.pack.add({}, { confirm = true, load = false })

--- Load an installed plugin. Returns false when installation was declined.
function M.ensure(name)
	local plugin_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "pack", "core", "opt", name)
	if vim.fn.isdirectory(plugin_dir) == 0 then
		return false
	end
	vim.pack.add({ spec(name) }, { confirm = true })
	return true
end

vim.api.nvim_create_user_command("PackInstall", function()
	local specs = {}
	for name in pairs(SRC) do
		table.insert(specs, spec(name))
	end
	vim.pack.add(specs, { confirm = true })
end, { desc = "Install configured Neovim plugins" })

return M
