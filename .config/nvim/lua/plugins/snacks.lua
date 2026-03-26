return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,

	keys = {
		{
			"<leader>e",
			function()
				Snacks.explorer.open()
			end,
			desc = "Open file explorer",
		},
		{
			"<leader>h",
			function()
				Snacks.terminal.toggle()
			end,
			desc = "Toggle terminal",
		},
	},
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		dashboard = {
			enabled = true,
			preset = {
				header = [[
       _                        
       \`*-.                    
        )  _`-.                 
       .  : `. .                
       : _   '  \               
       ; *` _.   `*-._          
       `-.-'          `-.       
         ;       `       `.     
         :.       .        \    
         . \  .   :   .-'   .   
         '  `+.;  ;  '      :   
         :  '  |    ;       ;-. 
         ; '   : :`-:     _.`* ;
[bug] .*' /  .*' ; .*`- +'  `*' 
      `*-*   `*-*  `*-*'␍
		]],
			},
		},
		bigfile = { enabled = true },
		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		terminal = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		explorer = { enabled = true },
	},
}
