return {
	{
		"gmartsenkov/gotospec.nvim",
		lazy = false,
		build = "make",
		dependencies = { "jghauser/mkdir.nvim" },
		config = true,
	},
	{
		"gmartsenkov/root.nvim",
		lazy = false,
		build = "make",
		config = function()
			require("root").setup({
				patterns = { ".git", "Gemfile", "gleam.toml" },
			})
		end,
	},
}
