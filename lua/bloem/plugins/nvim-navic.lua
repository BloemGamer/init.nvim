return {
	"SmiteshP/nvim-navic",
	priority = 1000,
	dependencies = {
	 "nvim-tree/nvim-web-devicons",
	 "neovim/nvim-lspconfig",
	},
	config = function ()
		require("nvim-navic").setup {
			highlight = true,
			lsp = {
				auto_attach = true,
			},
		}
	end

}
