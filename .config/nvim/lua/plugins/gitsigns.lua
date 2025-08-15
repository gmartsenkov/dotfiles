return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	opts = {
		current_line_blame = true,
		signcolumn = true,
		attach_to_untracked = false,
		preview_config = {
			border = "solid",
			row = 1,
			col = 1,
		},
		signs = {
			change = { text = "┋" },
		},
		signs_staged = {
			change = { text = "┋" },
		},
	},
	config = true,
}
