return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { { "RRethy/nvim-treesitter-endwise", lazy = false } },
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	opts = {
		highlight = {
			enable = true,
			use_languagetree = true,
			additional_vim_regex_highlighting = false,
		},
		ensure_installed = {
			"c",
			"clojure",
			"eex",
			"elixir",
			"erlang",
			"gleam",
			"heex",
			"html",
			"javascript",
			"typescript",
			"lua",
			"markdown",
			"ruby",
			"rust",
			"yaml",
			"surface",
			"vim",
			"vimdoc",
			"glimmer",
		},
		endwise = {
			enable = true,
		},
		indent = {
			enable = true,
			disable = {},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
