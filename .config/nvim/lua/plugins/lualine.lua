local sections = {
	lualine_a = {
		"mode",
	},
	lualine_b = {
		{ "filename", path = 1 },
	},
	lualine_c = {
		"diagnostics",
		"diff",
	},
	lualine_x = {},
	lualine_y = {
		"lsp_status",
	},
	lualine_z = {
		"location",
	},
}

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = true,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		theme = "catppuccin",
		extensions = { "toggleterm", "lazy", "nvim-tree", "mason", "overseer" },
		options = {
			always_divide_middle = false,
			disabled_filetypes = { "dashboard" },
			refresh = {
				statusline = 300,
			},
		},
		sections = sections,
		inactive_sections = sections,
	},
}
