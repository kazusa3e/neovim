if not require("pack").ensure("edge") then
	return
end

vim.opt.termguicolors = true
vim.g.edge_better_performance = 1
vim.g.edge_enable_italic = 1
vim.cmd.colorscheme("edge")
