return {
	"j-hui/fidget.nvim",
	opts = {
		progress = {
			suppress_on_insert = false,
			ignore_done_already = true,
			ignore_empty_message = true,

			display = {
				render_limit = 5,
				done_ttl = 2,
				done_icon = "✔",
				progress_icon = { pattern = "dots" },

				align = "bottom",
				relative = "editor",
			},
		},

		notification = {
			window = {
				winblend = 0,
				border = "none",
			},
		},
	},
}
