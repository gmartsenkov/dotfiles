local function peek_status()
	local fn = require("peek").fn
	local title = vim.fn.expand("%")
	return title .. ": " .. fn.position() .. " / " .. fn.result_count()
end

local peek_extension = {
	options = { refresh = { statusline = 100 } },
	sections = { lualine_a = { peek_status } },
	filetypes = { "peek" },
}

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = true,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		extensions = { "toggleterm", "lazy", "nvim-tree", "mason", peek_extension },
		options = {
			disabled_filetypes = { "dashboard" },
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
			lualine_x = { { "filetype" } },
		},
	},
}
