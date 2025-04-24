return{
    {
        'neovim/nvim-lspconfig',

        dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        },

        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { "lua_ls", "clangd", "pyright" },
                automatic_installation = true,
            }

            local lspconfig = require("lspconfig")

            local servers = { "lua_ls", "clangd", "pyright" }

            for _, server in ipairs(servers) do
                local opts = {}

                -- add Factorio-specific settings for lua_ls
                if server == "lua_ls" then
                    -- if on Windows
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
}
