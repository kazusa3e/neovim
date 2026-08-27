-- nvim-surround: add/delete/change surroundings (quotes, brackets, tags...).
-- Provides `ys`/`ds`/`cs`/`S` and native dot-repeat support.

if not require("pack").ensure("nvim-surround") then
	return
end

vim.keymap.set("n", "s", "<Plug>(nvim-surround-normal)", { desc = "Surround: add" })
vim.keymap.set("x", "s", "<Plug>(nvim-surround-visual)", { desc = "Surround: add to selection" })
