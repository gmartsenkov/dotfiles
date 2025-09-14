local spec_snippets = {
	"it",
	"desc",
	"rdesc",
	"fix",
	"let",
	"sub",
	"exp",
	"rdesc",
	"bef",
	"cont",
}
local function array_has(tbl, value)
	for _, v in ipairs(tbl) do
		if v == value then
			return true
		end
	end
	return false
end

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
			trigger = { show_in_snippet = true },
		},
		sources = {
			default = { "snippets", "lsp", "buffer", "path" },
			providers = {
				snippets = {
					min_keyword_length = 0,
					async = false,
					score_offset = 1000,
					should_show_items = function(ctx)
						if ctx.line:find("^%s*def ") then
							return false
						end
						return ctx.trigger.initial_kind ~= "trigger_character"
					end,
					transform_items = function(_, items)
						return vim.tbl_filter(function(item)
							local bufname = vim.api.nvim_buf_get_name(0)

							if not bufname:match("_spec") then
								if array_has(spec_snippets, item.label) then
									return false
								end
							end

							return true
						end, items)
					end,
				},
				lsp = { async = true, fallbacks = {}, score_offset = 3 },
				buffer = { score_offset = 1 },
				path = { fallbacks = {} },
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
