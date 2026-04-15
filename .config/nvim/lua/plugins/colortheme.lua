return {
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = false,
		priority = 1000,
		-- config = function()
		-- 	vim.cmd([[colorscheme moonfly]])
		-- end,
	},

	{
		"savq/melange-nvim",
		name = "melange",
		config = function()
			vim.cmd([[colorscheme melange]])
		end,
	}
	
}
