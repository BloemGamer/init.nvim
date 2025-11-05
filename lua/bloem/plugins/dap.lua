return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		config = function ()
			require("mason-nvim-dap").setup( {
				ensure_installed = {
					"cpptools",
					"debugpy",
					"codelldb",
				},
				automatic_installation = true,
			})

			local dap = require("dap")

			dap.adapters.cpptools = {
				id = "cppdbg",
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
			}

			dap.configurations.c = {
				{
					name = "Debug C file",
					type = "cpptools",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
					setupCommands = {
						{
							text = "-enable-pretty-printing",
							description = "enable pretty printing",
							ignoreFailures = false,
						},
						{
							text = "set substitute-path /run/host \"\"",
							description = "Fix distrobox paths",
							ignoreFailures = false,
						},
						{
							text = "directory " .. vim.fn.getcwd() .. "/src",
							description = "Add source directory",
							ignoreFailures = false,
						},
					},
				},
			}

			-- Alias for C++ and asm
			dap.configurations.cpp = dap.configurations.c
			dap.configurations.cpp[1].name = "Debug C++ file"
			dap.configurations.asm = dap.configurations.c
			dap.configurations.asm[1].name = "Debug ASM program"

			dap.adapters.python =
			{
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
				args = { "-m", "debugpy.adapter" },
			}

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Debug python file",
					program = "${file}",
					pythonPath = function()
						-- Use virtualenv if available, fallback to system python
						local venv_path = os.getenv("VIRTUAL_ENV")
						if venv_path then
							return venv_path .. "/bin/python3"
						else
							return "python3"
						end
					end,
					args = function()
						local args_string = vim.fn.input('Arguments: ')
						return vim.fn.split(args_string, " ", true)
					end,
				},
			}


			-- Rust/Codelldb Adapter
			dap.adapters.codelldb = function(callback, config)
				local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
				local adapter_path = codelldb_path .. "adapter/codelldb"
				local liblldb_path = codelldb_path .. "lldb/lib/liblldb" .. (vim.loop.os_uname().sysname == "Darwin" and ".dylib" or ".so")

				callback({
					type = "server",
					port = "${port}",
					executable = {
						command = adapter_path,
						args = { "--liblldb", liblldb_path, "--port", "${port}" },
						detached = true,
					}
				})
			end

			dap.configurations.rust = {
				{
					name = "Debug rust file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = function()
						local args_string = vim.fn.input("Arguments: ")
						return vim.fn.split(args_string, " ", true)
					end,
					runInTerminal = false,
				}
			}
		end


	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"nvim-neotest/nvim-nio"
		},
		config = function ()
			require("dapui").setup()
			vim.keymap.set("n", "<leader>dt", ":lua require(\"dapui\").toggle()<CR>", {noremap=true})
			vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", {noremap=true})
			vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", {noremap=true})
			vim.keymap.set("n", "<leader>dr", ":lua require('dapui').open({reset=true})<CR>", {noremap=true})
			vim.keymap.set("n", "<F5>", function() require("dap").continue() end)
			vim.keymap.set("n", "<F10>", function() require("dap").step_over() end)
			vim.keymap.set("n", "<F9>", function() require("dap").step_into() end)
			vim.keymap.set("n", "<F12>", function() require("dap").step_out() end)
		end


	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
		lazy = false,
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
}
