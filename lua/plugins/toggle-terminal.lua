-- toggleterm.nvim: persistent floating shell and terminal UIs.
-- Installed on first use (see lua/pack.lua).

if not require("pack").ensure("toggleterm.nvim") then
	return
end

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
vim.keymap.set("t", "<C-q>", [[<C-\><C-n><cmd>ToggleTerm direction=float<CR>]], { desc = "Toggle floating terminal" })
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
