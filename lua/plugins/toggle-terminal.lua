-- toggleterm.nvim: persistent floating shell and terminal UIs.
-- Installed on first use (see lua/pack.lua).

if not require("pack").ensure("toggleterm.nvim") then
	return
end

local function make_terminal_background_transparent()
	vim.api.nvim_set_hl(0, "TermNormal", { bg = "NONE" })
end

make_terminal_background_transparent()
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("ToggleTermTransparentBackground", { clear = true }),
	callback = make_terminal_background_transparent,
})

require("toggleterm").setup({
	open_mapping = nil,
	direction = "float",
	hide_numbers = true,
	shade_terminals = false,
	start_in_insert = true,
	insert_mappings = false,
	terminal_mappings = false,
	persist_mode = true,
	autochdir = true,
	float_opts = {
		border = "rounded",
		width = function()
			return math.floor(vim.o.columns * 0.9)
		end,
		height = function()
			return math.floor(vim.o.lines * 0.9)
		end,
	},
})

local function toggle_shell()
	vim.cmd("ToggleTerm direction=float")
end

vim.keymap.set("n", "<C-q>", toggle_shell, { desc = "Toggle floating terminal" })
vim.keymap.set("t", "<C-q>", [[<Cmd>ToggleTerm direction=float<CR>]], { desc = "Toggle floating terminal" })
vim.keymap.set("t", "`", [[<C-\><C-n>]], { desc = "Terminal normal mode" })

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	direction = "float",
	hidden = true,
	float_opts = { border = "rounded" },
})

vim.keymap.set("n", "<leader>gg", function()
	lazygit:toggle()
end, { desc = "Toggle LazyGit" })
