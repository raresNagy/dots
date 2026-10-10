return {
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = {
					{ name = "Moonfly", colorscheme = "moonfly" },
					{ name = "Melange", colorscheme = "melange" },
					{ name = "Kanagawa Wave", colorscheme = "kanagawa-wave" },
					{ name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
					{ name = "Kanagawa Lotus", colorscheme = "kanagawa-lotus" },
					{ name = "Gruvbox", colorscheme = "gruvbox" },
					{ name = "Zenbones", colorscheme = "zenbones" },
					{ name = "Zenwritten", colorscheme = "zenwritten" },
					{ name = "Zenburned", colorscheme = "zenburned" },
					{ name = "Duckbones", colorscheme = "duckbones" },
					{ name = "Neobones", colorscheme = "neobones" },
					{ name = "Nordbones", colorscheme = "nordbones" },
					{ name = "Rosebones", colorscheme = "rosebones" },
					{ name = "Seoulbones", colorscheme = "seoulbones" },
					{ name = "Tokyobones", colorscheme = "tokyobones" },
					{ name = "Vimbones", colorscheme = "vimbones" },
					{ name = "Forestbones", colorscheme = "forestbones" },
					{ name = "Kanagawabones", colorscheme = "kanagawabones" },
					{ name = "Randombones", colorscheme = "randombones" },
					{ name = "Randombones Dark", colorscheme = "randombones_dark" },
					{ name = "Randombones Light", colorscheme = "randombones_light" },
				},
			})
		end,
	},

	{
		"gruvbox-community/gruvbox",
		config = function()
			vim.g.gruvbox_italic = 1
			vim.g.gruvbox_transparent_bg = 1
			vim.g.gruvbox_italicize_strings = 1

			vim.g.gruvbox_contrast_dark = "hard"
		end,
	},

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
			vim.opt.background = "dark"
			vim.cmd.colorscheme("zenbones")
		end,
	},
}
