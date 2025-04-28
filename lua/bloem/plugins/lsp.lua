return
{
    {
        'neovim/nvim-lspconfig',

        dependencies =
        {
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
            require("mason-lspconfig").setup(
            {
                ensure_installed =
                {
                    "lua_ls",
                    "clangd",
                    "pyright",
                },
                automatic_installation = true,
                handlers =
                {
                    -- Default handler for all servers
                    function(server_name)
                        require("lspconfig")[server_name].setup {}
                    end,

                    -- Custom handler for lua_ls
                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        local opts =
                        {
                            settings = { Lua = { workspace = { library = {}, }, }, },
                            on_new_config = function(new_config, new_root_dir)
                                if vim.loop.os_uname().sysname == "Windows_NT" then
                                    if new_root_dir:find("Factorio") then
                                        new_config.settings.Lua.workspace.library[
                                        vim.fn.expand("C:\\Program Files (x86)\\Steam\\steamapps\\common\\Factorio\\doc-html\\node_modules\\.bin")
                                        ] = true
                                    end
                                end
                            end,
                        }

                        lspconfig.lua_ls.setup(opts)
                    end,
                },
            })

            vim.opt.signcolumn = 'yes'

            vim.diagnostic.config(
            {
                virtual_text =
               {
                    prefix = '*',
                    spacing = 2,
                },
                signs = true,
                underline = true,
                update_in_insert = false,
            })

            local lspconfig_defaults = require('lspconfig').util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            vim.api.nvim_create_autocmd('LspAttach',
            {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                end,
            })

            local cmp = require('cmp')

            cmp.setup(
            {
                sources =
                {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                },
                snippet =
                {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert(
                {
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                }),
            })
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
