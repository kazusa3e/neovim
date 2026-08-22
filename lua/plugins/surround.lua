-- vim-surround: add/delete/change surroundings (quotes, brackets, tags...).
-- Installed on first use (see lua/pack.lua). Provides `ys`/`ds`/`cs`/`S`.

if not require("pack").ensure("vim-surround") then
	return
end

vim.keymap.set("n", "s", "ys", { remap = true, desc = "Surround: add (ys)" })
vim.keymap.set("x", "s", "S", { remap = true, desc = "Surround: add to selection" })
