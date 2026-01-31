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
			local cache_path = vim.fn.stdpath("cache") .. "/catppuccin" -- hopefully a temporary fix, because otherwise the lualine theme would not load
			if vim.fn.isdirectory(cache_path) == 1 then
				vim.fn.delete(cache_path, "rf")
			end
			require("catppuccin").setup {
				flavour = "mocha",
				integrations = {
					lualine = true,
					navic = {
						enabled = true,
						custom_bg = "NONE",
					},
					-- notify = true,
					telescope = false,
				},
			}
			ColourPencils()
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = function()
					vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
				end,
			})
		end
	}
}
