return {
	"lewis6991/gitsigns.nvim",
	commit = "d9d94e055a19415767bb073e8dd86028105c4319",
	ft = { "gitcommit", "diff" },
	init = function()
		-- load gitsigns only when a git file is opened
		vim.api.nvim_create_autocmd({ "BufRead" }, {
			group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
			callback = function()
				vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
				if vim.v.shell_error == 0 then
					vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
					vim.schedule(function()
						require("lazy").load({ plugins = { "gitsigns.nvim" } })
					end)
				end
			end,
		})
	end,
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "󰍵" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "│" },
		},
	},
	config = true,
}
