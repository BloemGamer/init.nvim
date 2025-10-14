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

		telescope.setup( {
			defaults = {
				-- Ignore .git directories when searching for files
				file_ignore_patterns = {
					"%.exe$",
					"%.git/",
					"%.vscode/",
					"%.idea/",
					"%.venv/",
					"__pycache__/",
					"build/",
					"%.cache/",
					"addons/",
					"%.svg$",
					"%.uid$",
					"%.tscn$",
					"%.import$",
					"%.godot$",
					"target/",
					"Cargo.lock",
					"sdkconfig*"
				}
			},
		})

		vim.keymap.set('n', '<leader>pf', function() builtin.find_files({ no_ignore = true }) end, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>ph', function() builtin.find_files({ no_ignore = true, hidden = true }) end, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find files git' })
		vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = 'Telescope find with grep' })
		vim.keymap.set('n', '<leader>ps', builtin.lsp_document_symbols, { desc = 'Telescope find with grep' })
	end
}
