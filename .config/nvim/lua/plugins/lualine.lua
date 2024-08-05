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
	local type = vim.bo.filetype
	if type ~= "" then
		return "[" .. vim.bo.filetype .. "]"
	end
end

local lsp_progress = function()
	-- invoke `progress` here.
	return require("lsp-progress").progress()
end

local peek_extension = {
	sections = { lualine_b = { peek_status } },
	filetypes = { "peek" },
}

local sections = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = {
		"branch",
		{
			"filename",
			path = 4,
			fmt = function(value)
				local extension = vim.bo.filetype
				local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(extension, { default = true })

				return "[ " .. icon .. " " .. value .. " ]"
			end,
		},
		"diff",
		"diagnostics",
		"%=",
		{ current_signature, color = { fg = "#767a92", gui = "italic" } },
	},
	lualine_x = { lsp_progress, filetype },
	lualine_y = {},
	lualine_z = {},
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
		sections = sections,
		inactive_sections = sections,
	},
}
