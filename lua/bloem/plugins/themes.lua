function ColorPencils(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})

	vim.cmd("highlight Comment gui=italic")
	vim.cmd("highlight Keyword gui=bold")
end

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
			require('rose-pine').setup({
				-- disable_background = true,
				styles = {
					italic = true,
				},
			})
			ColorPencils()
        end
    },
    {
        "Mofiqul/vscode.nvim",
        as = 'vscode',
        config = function()
            ColorPencils()
        end
    },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		dependencies = {
			"SmiteshP/nvim-navic",
			'nvim-lualine/lualine.nvim',
			"rcarriga/nvim-notify",
		},
		config = function ()
			require("catppuccin").setup {
				flavour = "mocha",
				integrations = {
					lualine = true,
					navic = {
						enabled = true,
						custom_bg = "NONE", -- "lualine" will set background to mantle
					},
					notify = true,
					telescope = false,
				},
			}
			ColorPencils()
		end
	}
}
