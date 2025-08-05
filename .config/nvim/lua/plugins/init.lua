return {
	{ "nvim-lua/plenary.nvim", lazy = false },
	{
		"notjedi/nvim-rooter.lua",
		lazy = false,
		opts = {
			rooter_patterns = { ".git", "Gemfile", "gleam.toml" },
			trigger_patterns = { "*" },
			manual = true,
			fallback_to_parent = false,
			cd_scope = "global",
		},
		config = true,
	},
}
