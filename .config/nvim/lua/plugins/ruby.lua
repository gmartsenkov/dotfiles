function _G.set_ruby_keymaps()
	local opts = { buffer = 0 }
	local map = vim.keymap.set
	map("n", "<leader>tv", function()
		local current_file = vim.fn.expand("%")
		if string.find(current_file, "_spec") then
			require("neotest").run.run(current_file)
		else
			require("neotest").run.run(require("gotospec").jump_suggestion())
		end
	end, opts)
	map("n", "<leader>tc", function()
		require("neotest").run.run()
	end, opts)
end

-- vim.cmd("autocmd! Filetype ruby lua set_ruby_keymaps()")

return {}
