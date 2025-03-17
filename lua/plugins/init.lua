return{
	{'nvim-treesitter/nvim-treesitter', build = ":TSUpdate"},
	{'Mofiqul/vscode.nvim',
		as = 'vscode',
		config = function()
			vim.cmd('colorscheme vscode')
		end
	},
    {'mbbill/undotree'},
    {'nvim-telescope/telescope.nvim',
            tag = '0.1.8', requires = {{'nvim-lua/plenary.nvim'}}
    },
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
}
