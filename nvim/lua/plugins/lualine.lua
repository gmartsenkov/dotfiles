return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = true,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			disabled_filetypes = { "dashboard", "toggleterm", "peek" },
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
		sections = {
			lualine_b = { "branch" },
			lualine_c = {
				{
					"filename",
					path = 4,
				},
				"diff",
				"diagnostics",
			},
			lualine_x = { { "filetype", icon_only = true } },
		},
	},
}
