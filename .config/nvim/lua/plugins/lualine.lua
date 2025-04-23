local sections = {
	lualine_a = {
		"mode",
		"searchcount",
	},
	lualine_b = {},
	lualine_c = {
		{ "filename", path = 1 },
		"diff",
		"diagnostics",
		"%=",
	},
	lualine_x = {
		{ "overseer", unique = true },
		"lsp_status",
		"filetype",
	},
	lualine_y = {},
	lualine_z = {},
}

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = true,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		extensions = { "toggleterm", "lazy", "nvim-tree", "mason", "overseer" },
		options = {
			always_divide_middle = false,
			disabled_filetypes = { "dashboard" },
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			refresh = {
				statusline = 300,
			},
		},
		sections = sections,
		inactive_sections = sections,
	},
}
