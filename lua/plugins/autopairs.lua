if not require("pack").ensure("nvim-autopairs") then
	return
end

require("nvim-autopairs").setup({
	check_ts = true,
	disable_filetype = { "vim" },
})
