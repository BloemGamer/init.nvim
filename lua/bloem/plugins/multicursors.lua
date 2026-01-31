return {
	"smoka7/multicursors.nvim",
	event = "VeryLazy",
	dependencies = { "nvimtools/hydra.nvim" },
	opts = {
		-- disable any generated hints by using -2 for each mode
		generate_hints = {
			normal = -2,
			insert = -2,
			extend = -2,
		},
		-- optionally suppress the statusline hint as well
		hint_config = false,
	},
	keys = {
		-- start multi‑cursor commands
		{ mode = { 'n', 'v' }, '<C-n>', '<cmd>MCstart<cr>', desc = 'Start multi‑cursor' },
		{ mode = { 'n', 'v' }, '<Leader>u', '<cmd>MCunderCursor<cr>', desc = 'Start on char under cursor' },
		{ mode = { 'n', 'v' }, '<Leader>p', '<cmd>MCpattern<cr>', desc = 'Multi‑cursor by pattern' },
		-- clear
		{ '<Leader>c', '<cmd>MCclear<cr>', desc = 'Clear multi‑cursors' },
	},
}
