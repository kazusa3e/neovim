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
			-- Buffer words are a last-resort LSP fallback. Restrict them to the
			-- current buffer and a longer prefix to reduce unrelated suggestions.
			buffer = {
				min_keyword_length = function(ctx)
					return ctx.trigger.initial_kind == "manual" and 0 or 3
				end,
				opts = {
					get_bufnrs = function()
						return { vim.api.nvim_get_current_buf() }
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
