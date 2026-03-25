return { 
    'nvim-mini/mini.nvim', version = false,
    config = function()
	require("mini.ai").setup()
	require("mini.pairs").setup()
	require("mini.splitjoin").setup()
	require("mini.surround").setup()
	require("mini.git").setup()
	require("mini.cmdline").setup()
	require("mini.cmdline").setup()
	require("mini.icons").setup()
	require("mini.tabline").setup()
	require("mini.indentscope").setup({
	    draw = {
		delay = 10,
		animation = function()
		    return 20
		end
	    }
	}
    )
end
}

