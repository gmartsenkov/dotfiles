return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	cmd = "Neogit",
	config = true,
	opts = {
		kind = "tab",
		prompt_force_push = false,
		remember_settings = false,
		integrations = { telescope = false, snacks = true },
	},
}
