return {
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
			"L3MON4D3/LuaSnip", -- Better snippet engine
		},

		config = function()
			-- Setup Mason first
			require("mason").setup()

			-- Enhanced capabilities with nvim-cmp
			local capabilities = vim.tbl_deep_extend(
				'force',
				vim.lsp.protocol.make_client_capabilities(),
				require('cmp_nvim_lsp').default_capabilities()
			)

			-- Better diagnostic configuration
			vim.diagnostic.config({
				virtual_text = {
					prefix = '●',
					spacing = 2,
					severity_limit = vim.diagnostic.severity.WARN,
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = '✘',
						[vim.diagnostic.severity.WARN] = '▲',
						[vim.diagnostic.severity.HINT] = '⚑',
						[vim.diagnostic.severity.INFO] = '»',
					},
				},
				underline = true,
				update_in_insert = false,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})


			-- Sign column always visible
			vim.opt.signcolumn = 'yes'

			-- LSP server configurations
			local lspconfig = require("lspconfig")

			-- Default setup function
			local function default_setup(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end

			-- Server-specific configurations
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								library = { vim.env.VIMRUNTIME },
							},
							completion = { callSnippet = "Replace" },
							diagnostics = { globals = { "vim" } },
							hint = { enable = true },
						},
					},
				},

				rust_analyzer = {
					settings = {
						['rust-analyzer'] = {
							-- Inlay hints configuration
							inlayHints = {
								enable = true,
								bindingModeHints = { enable = false },
								chainingHints = { enable = true },
								closingBraceHints = {
									enable = true,
									minLines = 25,
								},
								closureReturnTypeHints = { enable = "never" },
								lifetimeElisionHints = {
									enable = "always",
									useParameterNames = false,
								},
								maxLength = 25,
								parameterHints = { enable = true },
								reborrowHints = { enable = "never" },
								renderColons = true,
								typeHints = {
									enable = true,
									hideClosureInitialization = false,
									hideNamedConstructor = false,
								},
							},
							-- Enhanced completion
							completion = {
								addCallArgumentSnippets = true,
								addCallParenthesis = true,
								postfix = { enable = true },
								privateEditable = { enable = true },
							},
							-- Better diagnostics
							diagnostics = {
								enable = true,
								experimental = { enable = true },
							},
							-- Auto-import settings
							imports = {
								granularity = { group = "module" },
								prefix = "self",
							},
							-- Cargo and proc macro support
							cargo = {
								buildScripts = { enable = true },
								features = "all",
							},
							procMacro = { enable = true },
							-- Check configuration
							check = {
								command = "clippy",
								features = "all",
							},
						}
					},
					capabilities = capabilities,
				},

				pyright = {
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "basic",
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "workspace",
							},
						},
					},
					capabilities = capabilities,
				},

				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--clang-tidy-checks=*",
						"--enable-config",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--fallback-style=llvm",
						"--pretty",
						"--log=verbose",
						"--cross-file-rename=true",
						"--hidden-features",
					},
					init_options = {
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
						semanticHighlighting = true,
						inlayHints = {
							parameterNames = true,
							parameterTypes = true,
							returnTypes = true,
						},
					},
					capabilities = capabilities,
				},

				asm_lsp = {
					cmd = { "asm-lsp" },
					filetypes = { "asm", "s", "S" },
					root_dir = lspconfig.util.root_pattern(".git", "."),
					capabilities = capabilities,
				},
			}

			-- Setup servers using the handlers table
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"pyright",
					"rust_analyzer",
				},
				automatic_installation = true,
				handlers = {
					-- Default handler for servers without custom config
					function(server_name)
						local config = servers[server_name] or {}
						config.capabilities = capabilities
						lspconfig[server_name].setup(config)
					end,
				},
			})

			-- LSP attach autocommand with keymaps
			vim.api.nvim_create_autocmd('LspAttach', {
				desc = 'LSP actions',
				callback = function(event)
					local opts = { buffer = event.buf, silent = true }
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					-- Navigation keymaps
					vim.keymap.set('n', 'K', function()
						vim.lsp.buf.hover({ border = "rounded" })
					end, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', 'gs', function()
						vim.lsp.buf.signature_help({ border = "rounded" })
					end, opts)

					-- Action keymaps
					vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'x' }, '<F3>', function()
						vim.lsp.buf.format({ async = true })
					end, opts)
					vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)

					-- Diagnostic keymaps
					vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
					vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
					vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

					-- Inlay hints toggle (if supported)
					if vim.lsp.inlay_hint and client and client:supports_method('textDocument/inlayHint') then
						vim.keymap.set('n', '<leader>h', function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
								{ bufnr = event.buf })
						end, opts)

						-- Auto-enable inlay hints for rust_analyzer
						if client.name == "rust_analyzer" then
							vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
						end
					end
				end,
			})

			-- Enhanced completion setup
			local cmp = require('cmp')
			local luasnip = require('luasnip')

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'nvim_lua' },
				}, {
					-- { name = 'buffer' },
					-- { name = 'path' },
				}),
				formatting = {
					format = function(entry, vim_item)
						-- Add source name
						vim_item.menu = ({
							nvim_lsp = '[LSP]',
							luasnip = '[Snippet]',
							nvim_lua = '[Lua]',
							-- buffer = '[Buffer]',
							-- path = '[Path]',
						})[entry.source.name]
						return vim_item
					end,
				},
				experimental = {
					ghost_text = true,
				},
			})

			-- Command line completion
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				})
			})
		end,
	},

	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		}
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {}
	},

	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
