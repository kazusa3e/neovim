if not require("pack").ensure("edge") then
	return
end

vim.opt.termguicolors = true
vim.g.edge_better_performance = 1
vim.g.edge_enable_italic = 1
vim.cmd.colorscheme("edge")

vim.api.nvim_set_hl(0, "DiffText", { fg = "#c5cdd9", bg = "#465a70" })
