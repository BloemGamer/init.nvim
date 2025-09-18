return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter")


			configs.setup(
				{
					ensure_installed =
					{
						"c",
						"cpp",
						"python",
						"rust",
						"lua"
					},
					sync_install = false,
					auto_install = true,
					highlight =
					{
						enable = true,
						additional_vim_regex_highlighting = false,
					},
					indent = { enable = true }
				})
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			-- Treesitter context setup
			require('treesitter-context').setup {
				enable = true,
				max_lines = 1,
			}

			-- Helper to lighten a hex color
			local function lighten(color, amount)
				color = color:gsub("#","")
				local r = tonumber(color:sub(1,2),16)
				local g = tonumber(color:sub(3,4),16)
				local b = tonumber(color:sub(5,6),16)

				r = math.min(255, math.floor(r + (255 - r) * amount))
				g = math.min(255, math.floor(g + (255 - g) * amount))
				b = math.min(255, math.floor(b + (255 - b) * amount))

				return string.format("#%02x%02x%02x", r, g, b)
			end

			-- Function to update TreesitterContext highlight based on current Normal bg
			local function update_context_highlight()
				local normal_hl = vim.api.nvim_get_hl_by_name('Normal', true)
				if normal_hl and normal_hl.background then
					local normal_bg = string.format("#%06x", normal_hl.background)
					local lighter_bg = lighten(normal_bg, 0.1)
					vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = lighter_bg, fg = nil })
					vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { bg = lighter_bg })
				end
			end

			-- Initial highlight setup
			update_context_highlight()

			-- Update highlights automatically on colorscheme change
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = update_context_highlight,
			})
		end
	}
}


