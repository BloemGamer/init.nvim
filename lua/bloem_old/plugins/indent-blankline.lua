return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {},
	config = function ()
		require("ibl").setup {
			scope = { enabled = false },
			indent = {
				char = "│",
				tab_char = "│",
			},
		}

		vim.opt.list = true
		vim.opt.listchars = {
			space = '·',
			tab = '→ ',      -- Arrow followed by space
			trail = '•',
			extends = '⟩',
			precedes = '⟨',
			nbsp = '␣',
		}
	end
}
