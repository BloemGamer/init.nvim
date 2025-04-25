return{
    {
        'neovim/nvim-lspconfig',

        dependencies = {
            "williamboman/mason.nvim",
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





            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "pyright",
                },
                handlers = {
                    -- Default handler for all servers
                    function(server_name)
                        require("lspconfig")[server_name].setup {}
                    end,

                    -- Custom handler for lua_ls
                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        local opts = {
                            settings = {
                                Lua = {
                                    workspace = {
                                        library = {},
                                    },
                                },
                            },
                                -- Only apply Factorio-specific config on Windows
                            on_new_config = function(new_config, new_root_dir)
                                if vim.loop.os_uname().sysname == "Windows_NT" then
                                    if new_root_dir:find("Factorio") then
                                        new_config.settings.Lua.workspace.library[vim.fn.expand("C:\\Program Files (x86)\\Steam\\steamapps\\common\\Factorio\\doc-html\\node_modules\\.bin")] = true
                                    end
                                end
                            end,
                        }

                        lspconfig.lua_ls.setup(opts)
                    end,
                },
            })
        end
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
