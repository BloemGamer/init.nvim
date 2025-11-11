return {
	'nvim-telescope/telescope.nvim',
	priority = 1000,
	--tag = '0.1.8',
	dependencies = {
		"nvim-lua/plenary.nvim",
		"BurntSushi/ripgrep"
	},

	config = function()
		local telescope = require('telescope')
		local builtin = require('telescope.builtin')

		telescope.setup({
				defaults = {
				-- Ignore patterns
				file_ignore_patterns = {
					"%.exe$",
					"%.git/",
					"%.vscode/",
					"%.idea/",
					"%.venv/",
					"__pycache__/",
					"build/",
					"buildw/",
					"build*/",
					"cmake%-build%-debug/",
					"%.cache/",
					"addons/",
					"%.svg$",
					"%.uid$",
					"%.tscn$",
					"%.import$",
					"%.godot$",
					"target/",
					"Cargo.lock",
					"sdkconfig*",
				},

				-- ✅ Fix: ensure Telescope closes before opening file
					mappings = {
						i = {
							["<CR>"] = function(prompt_bufnr)
								local actions = require("telescope.actions")
									local action_state = require("telescope.actions.state")
									local entry = action_state.get_selected_entry()
									actions.close(prompt_bufnr)
									vim.cmd("edit " .. vim.fn.fnameescape(entry.path))
									end,
						},
						n = {
							["<CR>"] = function(prompt_bufnr)
								local actions = require("telescope.actions")
									local action_state = require("telescope.actions.state")
									local entry = action_state.get_selected_entry()
									actions.close(prompt_bufnr)
									vim.cmd("edit " .. vim.fn.fnameescape(entry.path))
									end,
						},
					},
				},
		})

		vim.keymap.set('n', '<leader>pf', function() builtin.find_files({ no_ignore = true }) end, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>ph', function() builtin.find_files({ no_ignore = true, hidden = true }) end, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find files git' })
		vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = 'Telescope find with grep' })
		vim.keymap.set('n', '<leader>ps', builtin.lsp_document_symbols, { desc = 'Telescope find with grep' })
	end
}
