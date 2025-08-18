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
			menu = { border = "none" },
			documentation = { auto_show = true },
			ghost_text = { enabled = false },
			trigger = {
				show_in_snippet = true,
			},
		},
		sources = {
			default = { "snippets", "lsp", "buffer", "path" },
			providers = {
				snippets = {
					min_keyword_length = 0,
					async = false,
					score_offset = 1000,
				},
				lsp = {
					async = true,
					fallbacks = {},
					min_keyword_length = 2,
					score_offset = 3,
				},
				buffer = {
					min_keyword_length = 2,
					score_offset = 1,
				},
				path = {
					fallbacks = {},
				},
			},
		},

		fuzzy = {
			implementation = "prefer_rust_with_warning",
			use_frecency = false,
			use_proximity = true,
			sorts = {
				"exact",
				"score",
				"sort_text",
			},
			max_typos = function()
				return 1
			end,
		},
	},
}
