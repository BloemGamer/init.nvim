function ColourPencils(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)

	RemoveBackground()

	vim.cmd("highlight Comment gui=italic")
	vim.cmd("highlight Keyword gui=bold")
end

function RemoveBackground()
	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
	-- Remove Telescope background
	vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
	vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
	vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "none" })
	vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = "none" })
	vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = "none" })

	-- Clear window separator backgrounds
	vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
	vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })

	-- Clear other window-related backgrounds
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) -- Non-current windows
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" }) -- ~ characters

	vim.opt.fillchars = { eob = " " } -- Replace ~ with space
end

return {
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
			ColourPencils()
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = function()
					-- Clear backgrounds here
					vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
					-- ... rest of the highlights
				end,
			})
		end
	}
}
