return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = true,
		opts = {
			transparent_background = true,
			integrations = {
				blink_cmp = true,
			},
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "italic" },
				loops = {},
				functions = { "italic", "bold" },
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
