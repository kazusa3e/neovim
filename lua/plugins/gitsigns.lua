-- gitsigns.nvim: preview, stage, reset, and navigate Git hunks.
-- Installed on first use (see lua/pack.lua).

if not require("pack").ensure("gitsigns.nvim") then
	return
end

local gitsigns = require("gitsigns")

gitsigns.setup({
	signcolumn = false,
	numhl = true,
	word_diff = false,
	preview_config = {
		border = "rounded",
		col = 1,
		relative = "cursor",
		row = 0,
		style = "minimal",
	},
	on_attach = function(bufnr)
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		local function visual_range()
			local cursor_line = vim.fn.line(".")
			local anchor_line = vim.fn.line("v")
			return { math.min(cursor_line, anchor_line), math.max(cursor_line, anchor_line) }
		end

		map("n", "<leader>gd", gitsigns.preview_hunk, "Preview hunk")
		map("n", "<leader>ga", gitsigns.stage_hunk, "Stage hunk")
		map("x", "<leader>ga", function()
			gitsigns.stage_hunk(visual_range())
		end, "Stage selected hunks")
		map("n", "<leader>gr", gitsigns.reset_hunk, "Reset hunk")
		map("x", "<leader>gr", function()
			gitsigns.reset_hunk(visual_range())
		end, "Reset selected hunks")
		map("n", "<leader>gA", gitsigns.stage_buffer, "Stage buffer")
		map("n", "<leader>gR", gitsigns.reset_buffer, "Reset buffer")

		map("n", "[g", function()
			gitsigns.nav_hunk("prev")
		end, "Previous hunk")
		map("n", "]g", function()
			gitsigns.nav_hunk("next")
		end, "Next hunk")
		map("n", "[G", function()
			gitsigns.nav_hunk("first")
		end, "First hunk")
		map("n", "]G", function()
			gitsigns.nav_hunk("last")
		end, "Last hunk")
		map({ "o", "x" }, "gh", gitsigns.select_hunk, "Select hunk")
	end,
})

vim.api.nvim_set_hl(0, "GitSignsAddNr", { link = "GitSignsAdd" })
vim.api.nvim_set_hl(0, "GitSignsChangeNr", { link = "GitSignsChange" })
vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { link = "GitSignsDelete" })

-- The default TermCursor fallback has poor contrast with Edge.
vim.api.nvim_set_hl(0, "GitSignsAddInline", { link = "DiffText" })
vim.api.nvim_set_hl(0, "GitSignsChangeInline", { link = "DiffText" })
vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { link = "DiffText" })
