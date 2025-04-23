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
    {
        'neovim/nvim-lspconfig',
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { "lua_ls", "clangd", "pyright" },
                automatic_installation = true,
            }

            local lspconfig = require("lspconfig")

            local servers = { "lua_ls", "clangd", "pyright" }

            for _, server in ipairs(servers) do
                local opts = {}

                -- Add Factorio-specific settings for lua_ls
                if server == "lua_ls" then
                    -- If on Windows (since you're using C:\\...)
                    if os.getenv("HOME") == nil then
                    opts.on_new_config = function(new_config, new_root_dir)
                        if new_root_dir:find("Factorio") then
                                new_config.settings = vim.tbl_deep_extend("force", new_config.settings or {}, {
                                    Lua = {
                                        workspace = {
                                            library = {
                                                [vim.fn.expand("C:\\Program Files (x86)\\Steam\\steamapps\\common\\Factorio\\doc-html\\node_modules\\.bin")] = true,
                                            },
                                        },
                                    },
                                })
                            end
                        end
                    end
                end

                lspconfig[server].setup(opts)
            end
        end,
    },
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-nvim-lua'},
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
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                disable_background = true,
                styles = {
                    italic = false,
                },
            })

        end
    },
    }
