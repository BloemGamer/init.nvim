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
					enable = false,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					},
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
					glyphs = {
						default = " ",
						symlink = " ",
						bookmark = "B",
						modified = "●",
						hidden = "H",
						folder = {
							arrow_closed = "-",
							arrow_open = "+",
							default = " ",
							open = " ",
							empty = " ",
							empty_open = " ",
							symlink = " ",
							symlink_open = " ",
						},
						git = {
							unstaged = "!",
							staged = "S",
							unmerged = "U",
							renamed = "R",
							untracked = "★",
							deleted = "D",
							ignored = "I",
						},
					},
				},
			},
		}
	end

}
