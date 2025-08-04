function _G.set_go_keymaps()
	local opts = { buffer = 0 }
	local map = vim.keymap.set
	map("n", "<leader>mb", function()
		local terminals = require("toggleterm.terminal").get_all()
		for _, term in ipairs(terminals) do
			if vim.api.nvim_win_is_valid(term.window) then
				vim.api.nvim_win_close(term.window, true)
			end
		end
		vim.cmd("TermExec cmd='go build .'")
	end, opts)
	map("n", "<leader>mr", function()
		local terminals = require("toggleterm.terminal").get_all()
		for _, term in ipairs(terminals) do
			if vim.api.nvim_win_is_valid(term.window) then
				vim.api.nvim_win_close(term.window, true)
			end
		end
		vim.cmd("TermExec cmd='go run .'")
	end, opts)
	map("n", "<leader>ta", function()
		local terminals = require("toggleterm.terminal").get_all()
		for _, term in ipairs(terminals) do
			if vim.api.nvim_win_is_valid(term.window) then
				vim.api.nvim_win_close(term.window, true)
			end
		end
		vim.cmd("TermExec cmd='go test .'")
	end, opts)
end

vim.cmd("autocmd! Filetype go lua set_go_keymaps()")

return {}
