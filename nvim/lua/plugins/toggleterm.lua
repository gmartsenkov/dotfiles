function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
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
