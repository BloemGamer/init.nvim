return {
	"SmiteshP/nvim-navic",
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
