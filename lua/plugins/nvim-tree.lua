if not require("pack").ensure("nvim-tree.lua") then
	return
end

require("pack").ensure("nvim-web-devicons")

-- Keep netrw available when the explorer is disabled or not installed.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	sync_root_with_cwd = true,
	view = {
		side = "left",
		width = 32,
	},
	renderer = {
		group_empty = true,
		highlight_git = "name",
		indent_markers = { enable = true },
	},
	update_focused_file = { enable = true },
	-- Browsing the tree must not change the picker's or terminal's working directory.
	actions = { change_dir = { enable = false } },
	filters = {
		dotfiles = false,
		git_ignored = false,
		custom = { "^\\.git$", "^\\.DS_Store$" },
	},
})

local api = require("nvim-tree.api")

vim.keymap.set("n", "<leader>e", function()
	api.tree.toggle({ find_file = true })
end, { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>E", function()
	api.tree.find_file({ open = true, focus = true, update_root = true })
end, { desc = "Reveal current file in tree" })
