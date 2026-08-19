require("pack").ensure("mini.pick")

local pick = require("mini.pick")
pick.setup()

vim.keymap.set("n", "<leader>p", pick.builtin.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>s", pick.builtin.buffers, { desc = "Pick buffer" })
vim.keymap.set("n", "<leader>/", pick.builtin.grep_live, { desc = "Live grep" })
-- vim.keymap.set("n", "<leader>r", pick.builtin.resume, { desc = "Resume last picker" })

-- 旧文件（最近打开）picker：走 vim.ui.select（setup 后已被 mini.pick 接管）
local function oldfiles()
	local items = {}
	for _, f in ipairs(vim.v.oldfiles) do
		if vim.fn.filereadable(f) == 1 then
			table.insert(items, f)
		end
	end
	vim.ui.select(items, {
		prompt = "Oldfiles",
		format_item = function(f)
			return vim.fn.fnamemodify(f, ":p:.")
		end,
	}, function(sel)
		if sel then
			vim.cmd.edit(vim.fn.fnameescape(sel))
		end
	end)
end

vim.keymap.set("n", "<leader>o", oldfiles, { desc = "Old files (recent)" })
MiniPick.registry.oldfiles = oldfiles -- 也可以 :Pick oldfiles
