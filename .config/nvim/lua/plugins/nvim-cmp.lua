return {
	"saghen/blink.cmp",
	dependencies = {
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		config = function()
			require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
		end,
	},
	version = "1.*",
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
						return cmp.accept()
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

		snippets = { preset = "luasnip" },
		signature = { enabled = true },
		completion = {
			documentation = { auto_show = true },
			ghost_text = { enabled = true },
			trigger = {
				show_in_snippet = false,
			},
		},

		sources = {
			default = { "snippets", "lsp", "path", "buffer" },
			providers = {
				snippets = {
					min_keyword_length = 2,
					score_offset = 10,
				},
				lsp = {
					min_keyword_length = 2,
					score_offset = 3,
				},
				path = {
					min_keyword_length = 3,
					score_offset = 2,
				},
				buffer = {
					min_keyword_length = 2,
					score_offset = 1,
				},
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
