-- mini.diff: show git diff hunks in the sign column + navigate/apply hunks.
-- Installed on first use (see lua/pack.lua). Requires git >= 2.38.

if not require("pack").ensure("mini.diff") then
	return
end

local minidiff = require("mini.diff")
minidiff.setup({
	view = {
		-- style = "sign", -- or 'number'
		style = "number"
	},
	mappings = {
		apply = "<leader>ga",
		reset = "<leader>gr",
		-- textobject stays 'gh' (operator-pending/visual only; `dgh`/`ygh`
		-- delete/yank the hunk range, no clash with normal-mode `gh`).
		goto_first = "[G",
		goto_last = "]G",
		goto_prev = "[g",
		goto_next = "]g",
	},
})

vim.keymap.set("n", "<leader>gr", function()
	return minidiff.operator("reset") .. "gh"
end, { expr = true, remap = true, desc = "Reset hunk" })
