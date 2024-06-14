local function peek_status()
	local fn = require("peek").fn
	local title = vim.fn.expand("%")
	return title .. ": " .. fn.position() .. " / " .. fn.result_count()
end

local current_signature = function()
	if not pcall(require, "lsp_signature") then
		return
	end
	local sig = require("lsp_signature").status_line(100)
	return sig.label
end

local filetype = function()
	return "[" .. vim.bo.filetype .. "]"
end

local lsp_progress = function()
	-- invoke `progress` here.
	return require("lsp-progress").progress()
end

local peek_extension = {
	sections = { lualine_b = { peek_status } },
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
			always_divide_middle = false,
			disabled_filetypes = { "dashboard" },
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			refresh = {
				statusline = 300,
			},
		},
		sections = {
			lualine_a = {},
			lualine_b = { {
				"branch",
				fmt = function(branch)
					return branch:sub(1, 30)
				end,
			} },
			lualine_c = {
				{
					"filename",
					path = 1,
				},
				"diff",
				"diagnostics",
				current_signature,
			},
			lualine_x = { lsp_progress, filetype },
			lualine_y = {},
			lualine_z = {},
		},
	},
}
