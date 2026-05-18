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
	},
	{
	"rebelot/kanagawa.nvim",
	compile = true;
		config = function()
			vim.cmd([[colorscheme kanagawa]])
		end,

	}
}
