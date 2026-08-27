if not require("pack").ensure("blink.cmp") then
	return
end

require("blink.cmp").setup({
	-- Tab accepts completion and moves through snippet placeholders.
	keymap = { preset = "super-tab" },

	completion = {
		-- Avoid opening another completion menu while moving through a snippet.
		trigger = { show_in_snippet = false },
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
		},
	},

	sources = {
		providers = {
			lsp = {
				-- Show buffer words alongside LSP results instead of only as a fallback.
				fallbacks = {},
			},

			buffer = {
				-- Scan all loaded, listed file buffers, including hidden buffers.
				min_keyword_length = function(ctx)
					return ctx.trigger.initial_kind == "manual" and 0 or 3
				end,
				opts = {
					get_bufnrs = function()
						return vim.tbl_filter(function(bufnr)
							return vim.bo[bufnr].buflisted
								and vim.api.nvim_buf_is_loaded(bufnr)
								and vim.bo[bufnr].buftype == ""
						end, vim.api.nvim_list_bufs())
					end,
				},
			},
		},
	},

	signature = { enabled = true },
	-- Build manually after install/update with `nix run .#build-plugin` in the plugin directory.
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = { download = false },
	},
})
