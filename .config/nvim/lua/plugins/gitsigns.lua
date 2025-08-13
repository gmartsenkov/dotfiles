return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	opts = {
		current_line_blame = true,
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "󰍵" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "│" },
		},
	},
	config = true,
}
