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
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- optional
        config = true
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = true
    },
    {'neovim/nvim-lspconfig',
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { "lua_ls", "clangd", "pyright" }, -- change this list
                automatic_installation = true,
            }

            local lspconfig = require("lspconfig")
            local servers = { "lua_ls", "clangd", "pyright"} -- same list here

            for _, server in ipairs(servers) do
                lspconfig[server].setup({})
            end
        end,
    },
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'altermo/ultimate-autopair.nvim',
    event={'InsertEnter','CmdlineEnter'},
    branch='v0.6', --recommended as each new version will have breaking changes
    opts={
        --Config goes here
    },},
    {'tpope/vim-fugitive'},
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        settings = {
            save_on_toggle = false,
            sync_on_ui_close = false,
            key = function()
                return vim.loop.cwd()
            end,
        },
    }
}
