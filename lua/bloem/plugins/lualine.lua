return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			'arkav/lualine-lsp-progress',
		},
		config = function ()
			require('lualine').setup {
				options = {
					icons_enabled = true,
					theme = "catppuccin",
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {
						"filename",
						"lsp_progress",
						{
							function() return require("nvim-navic").get_location() end,
							cond = function() return require("nvim-navic").is_available() end,
						},
					},
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			}
		end
	},
}
