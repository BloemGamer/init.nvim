return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"catppuccin/nvim",
		},
		config = function()
			local function recording_status()
				local reg = vim.fn.reg_recording()
				if reg == "" then
					return ""
				else
					return "@" .. reg
				end
			end

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "catppuccin",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {
						"filename",
						{
							function()
								return require("nvim-navic").get_location()
							end,
							cond = function()
								return require("nvim-navic").is_available()
							end,
						},
					},
					lualine_x = {
						recording_status,
						"encoding",
						"fileformat",
						"filetype",
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})

			vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
				callback = function()
					vim.defer_fn(require("lualine").refresh, 50)
				end,
			})
		end,
	},
}
