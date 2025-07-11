return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},
	cmd = "Neogit",
	config = true,
	opts = {
		kind = "vsplit",
		remember_settings = false,
		integrations = { telescope = false, snacks = true },
	},
}
