if not require("pack").ensure("which-key.nvim") then
	return
end

local wk = require("which-key")
wk.setup({})

vim.keymap.set("n", "<leader>?", function()
	wk.show({ global = false })
end, { desc = "Buffer-local keymaps" })
