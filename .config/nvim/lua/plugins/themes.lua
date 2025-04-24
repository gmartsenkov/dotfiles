return {
	{
		"rebelot/kanagawa.nvim",
		config = true,
		opts = {
			functionStyle = { italic = true, bold = true },
			commentStyle = { italic = true },
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = true,
		opts = {
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
				conditionals = {},
				loops = {},
				functions = {},
				keywords = { "italic" },
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
				-- miscs = {}, -- Uncomment to turn off hard-coded styles
			},
		},
	},
}
