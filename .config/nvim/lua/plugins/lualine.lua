local filetype = function()
	local type = vim.bo.filetype
	if type ~= "" then
		return "[" .. vim.bo.filetype .. "]"
	end
end

local lsp_progress = function()
	-- invoke `progress` here.
	return require("lsp-progress").progress()
end

local sections = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = {
		{
			"filename",
			path = 4,
			fmt = function(value)
				local extension = vim.bo.filetype
				local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(extension, { default = true })

				return icon .. " " .. value
			end,
		},
		"diff",
		"diagnostics",
		"%=",
	},
	lualine_x = {
		lsp_progress,
		filetype,
		-- { "branch", fmt = function(str) return str:sub(1,10) end },
	},
	lualine_y = {},
	lualine_z = {},
}

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = true,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		{
			"linrongbin16/lsp-progress.nvim",
			config = true,
			opts = { max_size = 50 },
		},
	},
	opts = {
		extensions = { "toggleterm", "lazy", "nvim-tree", "mason" },
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
