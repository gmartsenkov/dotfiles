return {
	"saghen/blink.cmp",
	version = "1.*",
	lazy = false,
	opts = {
		keymap = {
			preset = "default",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<CR>"] = {
				function(cmp)
					return cmp.select_and_accept()
				end,
				"fallback",
			},
			["<Tab>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return nil
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward",
				"fallback",
			},
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		signature = { enabled = true },
		completion = {
			documentation = { auto_show = true },
			ghost_text = { enabled = true },
			trigger = {
				show_in_snippet = true,
			},
		},
		sources = {
			default = { "snippets", "lsp", "buffer" },
			providers = {
				snippets = {
					min_keyword_length = 2,
					score_offset = 10,
				},
				lsp = {
					async = true,
					min_keyword_length = 2,
					score_offset = 3,
				},
				buffer = {
					min_keyword_length = 2,
					score_offset = 1,
				},
			},
		},

		fuzzy = {
			implementation = "prefer_rust_with_warning",
			use_frecency = false,
			use_proximity = true,
			max_typos = function()
				return 0
			end,
		},
	},
}
