return {
	"folke/snacks.nvim",
	lazy = false,
	config = function(_, opts)
		require("snacks").setup(opts)
		vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#333333" })
		vim.api.nvim_set_hl(0, "SnacksIndentChunk", { fg = "#575757" })
		vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#575757" })
	end,
	opts = {
		dashboard = { enabled = true },
		words = { enabled = false },
		scope = { enabled = false },
		indent = {
			hl = "SnacksIndent",
			enabled = true,
			animate = { enabled = false },
			chunk = { enabled = true, char = { arrow = "─" } },
		},
		input = { enabled = false },
		bigfile = { enabled = false },
		statuscolumn = { enabled = false },
		dim = { enabled = false },
		zen = { enabled = false },
		notifier = { enabled = false },
		picker = {
			win = {
				input = {
					keys = {
						["<Esc>"] = { "close", mode = { "n", "i" } },
						["<c-a>"] = {
							function()
								vim.cmd("normal ^")
							end,
							mode = { "i" },
						},
						["<c-e>"] = {
							function()
								local cursor = vim.api.nvim_win_get_cursor(0)
								vim.api.nvim_win_set_cursor(0, { cursor[1], vim.v.maxcol })
							end,
							mode = { "i" },
						},
					},
				},
			},
			formatters = {
				file = {
					-- filename_first = true,
					truncate = 160,
				},
			},
			matcher = {
				frecency = true,
			},
			sources = {
				files = {
					prompt = "󰍉 ",
					layout = {
						preview = true,
						layout = {
							backdrop = false,
							row = 2,
							width = 120,
							min_width = 80,
							height = 0.6,
							border = "none",
							box = "vertical",
							{
								win = "input",
								height = 1,
								row = 1,
								border = "single",
								title = "{title} {live} {flags}",
								title_pos = "left",
							},
							{
								win = "list",
								border = "single",
							},
							{
								box = "vertical",
								{
									win = "preview",
									title = "{preview}",
									border = "single",
									minimal = true,
								},
							},
						},
					},
				},
				diagnostics = {
					layout = { preset = "dropdown" },
				},
				buffers = {
					prompt = "󰍉 ",
					layout = {
						layout = {
							backdrop = false,
							row = 2,
							width = 120,
							min_width = 80,
							height = 0.6,
							border = "none",
							box = "vertical",
							{
								win = "input",
								height = 1,
								row = 1,
								border = "single",
								title = "{title} {live} {flags}",
								title_pos = "left",
							},
							{ win = "list", border = "single" },
						},
					},
				},
				grep = {
					prompt = "󰍉 ",
					layout = {
						preview = true,
						layout = {
							backdrop = false,
							row = 2,
							width = 120,
							min_width = 80,
							height = 0.8,
							border = "none",
							box = "vertical",
							title = "",
							{
								win = "input",
								height = 1,
								row = 1,
								border = "single",
								title = "{title} {live} {flags}",
								title_pos = "center",
							},
							{
								box = "horizontal",
								{ win = "list", border = "single" },
								{
									win = "preview",
									title = "{preview}",
									border = "single",
									width = 0.5,
									minimal = true,
								},
							},
						},
					},
				},
				lsp_references = {
					prompt = " ",
					layout = {
						preview = true,
						layout = {
							backdrop = false,
							row = 2,
							width = 150,
							min_width = 80,
							height = 0.8,
							border = "none",
							box = "vertical",
							title = "",
							{
								win = "input",
								height = 1,
								row = 1,
								border = "single",
								title = "{title} {live} {flags}",
								title_pos = "center",
							},
							{
								box = "horizontal",
								{ win = "list", border = "single" },
								{
									win = "preview",
									title = "{preview}",
									border = "single",
									width = 0.5,
									minimal = true,
								},
							},
						},
					},
				},
			},
		},
	},
}
