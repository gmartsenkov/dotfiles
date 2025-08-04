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
			"glimmer",
			"go",
			"heex",
			"html",
			"javascript",
			"lua",
			"markdown",
			"ruby",
			"rust",
			"surface",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
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
