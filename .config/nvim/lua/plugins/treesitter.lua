return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{ "RRethy/nvim-treesitter-endwise", lazy = true },
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSTextobjectSelect" },
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		opts = {
			highlight = {
				enable = true,
				use_languagetree = true,
				additional_vim_regex_highlighting = false,
			},
			ensure_installed = {
				"c",
				"clojure",
				"eex",
				"elixir",
				"erlang",
				"gleam",
				"glimmer",
				"go",
				"heex",
				"html",
				"javascript",
				"lua",
				"markdown",
				"ruby",
				"rust",
				"surface",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			endwise = {
				enable = true,
			},
			indent = {
				enable = true,
				disable = {},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = false,
		cmd = { "TSTextobjectSelect" },
		config = function()
			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

			-- Repeat movement with ; and ,
			-- ensure ; goes forward and , goes backward regardless of the last direction
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

			require("nvim-treesitter.configs").setup({
				textobjects = {
					enable = true,
					lookahead = true,
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]c"] = "@class.outer",
							["]f"] = "@function.outer",
							["]a"] = "@parameter.inner",
						},
						goto_next_end = {
							["]["] = "@class.outer",
							["]F"] = "@function.outer",
						},
						goto_previous_start = {
							["[c"] = "@class.outer",
							["[f"] = "@function.outer",
							["[a"] = "@parameter.inner",
						},
						goto_previous_end = {
							["]F"] = "@function.outer",
							["[C"] = "@class.outer",
						},
					},
					select = {
						enable = true,
						keymaps = {
							["iC"] = "@call.inner",
							["aC"] = "@call.outer",
							["ic"] = "@conditional.inner",
							["ac"] = "@conditional.outer",
							["if"] = "@function.inner",
							["af"] = "@function.outer",
							["il"] = "@loop.inner",
							["al"] = "@loop.outer",
							["ib"] = "@block.inner",
							["ab"] = "@block.outer",
						},
					},
					swap = { enable = false },
				},
			})
		end,
	},
}
