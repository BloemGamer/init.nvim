return {
	"nvim-tree/nvim-tree.lua",
	config = function ()

		-- optionally enable 24-bit colour
		vim.opt.termguicolors = true

		vim.keymap.set('n', '<leader>pt',    ':NvimTreeToggle<CR>')

		-- empty setup using defaults
		require("nvim-tree").setup {
			hijack_netrw = false,
			renderer = {
				indent_markers = {
					enable = true,
					inline_arrows = true,
				},
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
						modified = true,
						hidden = false,
						diagnostics = true,
						bookmarks = true,
					},
				},
			},
		}
	end

}
