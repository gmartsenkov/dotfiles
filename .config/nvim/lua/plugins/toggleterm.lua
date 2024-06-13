function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("n", "<esc>", function()
		local origin_win = require("toggleterm.ui").get_origin_window()
		vim.api.nvim_win_close(0, true)
		if vim.api.nvim_win_is_valid(origin_win) then
			vim.api.nvim_set_current_win(origin_win)
		end
	end, opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
end

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	lazy = false,
	opts = {
		close_on_exit = true,
		direction = "horizontal",
		shade_terminals = false,
		open_mapping = [[<C-t>]],
		size = function(term)
			if term.direction == "horizontal" then
				return vim.o.lines * 0.4
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)
		vim.cmd("autocmd! TermOpen term://*toggleterm#*  lua set_terminal_keymaps()")
	end,
}
