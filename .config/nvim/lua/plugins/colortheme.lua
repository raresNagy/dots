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
		compile = true,
		-- config = function()
		-- 	vim.cmd([[colorscheme kanagawa]])
		-- end,
	},

	{
		"zenbones-theme/zenbones.nvim",
		-- Optionally install Lush. Allows for more configuration or extending the colorscheme
		-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
		-- In Vim, compat mode is turned on as Lush only works in Neovim.
		dependencies = "rktjmp/lush.nvim",
		lazy = false,
		priority = 1000,
		-- you can set set configuration options here
		config = function()
			vim.opt.termguicolors = true
		    vim.g.zenbones_darken_comments = 45
			vim.g.zenbones_compat = 1
			vim.opt.background = "dark"
		    vim.cmd.colorscheme('zenbones')
		end
	},
}
